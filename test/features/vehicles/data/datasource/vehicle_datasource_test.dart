import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/datasources/vehicles_datasource.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/vehicle_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  VehiclesRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = VehiclesRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('vehicles.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getVehicles', () {
    var eVehicles = <VehicleModel>[];
    for (var j in json.decode(fixture('vehicles.json'))) {
      eVehicles.add(VehicleModel.fromJson(j));
    }

    test(
      '''should perform a GET request on a URL /vehicles''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getVehicles();
        // assert
        verify(mockHttpClient.get('https://sss.suma.guru/api/vehicles'));
      },
    );

    test(
      'should return List<Vehicles> when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getVehicles();
        // assert
        expect(result, equals(eVehicles));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getVehicles;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getTripsForVehicle', () {
    var eVehicles = <VehicleModel>[];
    for (var j in json.decode(fixture('vehicles.json'))) {
      eVehicles.add(VehicleModel.fromJson(j));
    }

    test(
      '''should perform a GET request on a URL /vehicles''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getVehicles();
        // assert
        verify(mockHttpClient.get('https://sss.suma.guru/api/vehicles'));
      },
    );

    test(
      'should return List<Vehicles> when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getVehicles();
        // assert
        expect(result, equals(eVehicles));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getVehicles;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
