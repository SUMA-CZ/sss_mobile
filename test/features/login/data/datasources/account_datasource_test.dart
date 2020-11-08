import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/datasources/account_datasource.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/models/e_token_model.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/models/e_user_credentitials_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  AccountDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AccountDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200ForLogin() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('account.json'), 200));
  }

  void setUpMockHttpClientFailedForLogin() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('account400.json'), 400));
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
        dataSource.authenticate(creds);
        // assert
        verify(mockHttpClient.post('https://sss.suma.guru/api/Account/Login'));
      },
    );

    test(
      'should return Token when the response code is 200 (success)',
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
