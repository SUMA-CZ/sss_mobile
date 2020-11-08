import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/datasources/account_datasource.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/models/e_token_model.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/models/e_user_credentitials_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Dio {}

class DioAdapterMock extends Mock implements HttpClientAdapter {}

const dioHttpHeadersForResponseBody = {
  Headers.contentTypeHeader: [Headers.jsonContentType],
};

void main() {
  final Dio dio = Dio();
  AccountDataSourceImpl dataSource;
  DioAdapterMock dioAdapterMock;

  setUp(() {
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    dataSource = AccountDataSourceImpl(client: dio);
  });

  void setUpMockHttpClientSuccess200ForLogin() {
    final responsePayload = json.encode(fixture('account.json'));
    final httpResponse = ResponseBody.fromString(
      responsePayload,
      200,
      headers: dioHttpHeadersForResponseBody,
    );

    when(dioAdapterMock.fetch(any, any, any)).thenAnswer((_) async => httpResponse);
  }

  void setUpMockHttpClientFailedForLogin() {
    final responsePayload = json.encode(fixture('account400.json'));
    final httpResponse = ResponseBody.fromString(
      responsePayload,
      400,
      headers: dioHttpHeadersForResponseBody,
    );

    when(dioAdapterMock.fetch(any, any, any)).thenAnswer((_) async => httpResponse);
  }

  group('login', () {
    final token = ETokenModel.fromJson(json.decode(fixture('account.json')));
    final creds = EUserCredentialsModel(username: 'null', password: 'null');
    test(
      '''should perform a POST request on a URL /account/login''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200ForLogin();
        // act

        final result = await dataSource.authenticate(creds);
        // assert
        expect(result, equals(token));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailedForLogin();
        // assert
        expect(() => dataSource.authenticate(creds), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
