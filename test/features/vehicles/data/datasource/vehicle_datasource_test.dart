import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/datasources/vehicles_datasource.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_maintenance_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_refueling_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_trip_model.dart';
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

  void setUpMockHttpClientSuccess200ForVehicles() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('vehicles.json'), 200));
  }

  void setUpMockHttpClientSuccess200ForTrips() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trips.json'), 200));
  }

  void setUpMockHttpClientSuccess200ForRefueling() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('refuelings.json'), 200));
  }

  void setUpMockHttpClientSuccess200ForMaintenances() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('maintenances.json'), 200));
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
        setUpMockHttpClientSuccess200ForVehicles();
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
        setUpMockHttpClientSuccess200ForVehicles();
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
    var eTrips = <ETripModel>[];
    for (var j in json.decode(fixture('trips.json'))) {
      eTrips.add(ETripModel.fromJson(j));
    }

    final vehicleID = 16;

    test(
      '''should perform a GET request on a URL /vehicles''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200ForTrips();
        // act
        dataSource.getTripsForVehicleID(vehicleID);
        // assert
        verify(mockHttpClient.get('https://sss.suma.guru/api/vehicles/${vehicleID}/trips'));
      },
    );

    test(
      'should return List<TripModel> when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200ForTrips();
        // act
        final result = await dataSource.getTripsForVehicleID(vehicleID);
        // assert
        expect(result, equals(eTrips));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getTripsForVehicleID;
        // assert
        expect(() => call(vehicleID), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getRefuelingsForVehicle', () {
    var eRefuelingModels = <ERefuelingModel>[];
    for (var j in json.decode(fixture('refuelings.json'))) {
      eRefuelingModels.add(ERefuelingModel.fromJson(j));
    }

    final vehicleID = 16;

    test(
      '''should perform a GET request on a URL /vehicles''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200ForRefueling();
        // act
        dataSource.getRefuelingsForVehicleID(vehicleID);
        // assert
        verify(mockHttpClient.get('https://sss.suma.guru/api/vehicles/${vehicleID}/refuelings'));
      },
    );

    test(
      'should return List<RefuelingModel> when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200ForRefueling();
        // act
        final result = await dataSource.getRefuelingsForVehicleID(vehicleID);
        // assert
        expect(result, equals(eRefuelingModels));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getRefuelingsForVehicleID;
        // assert
        expect(() => call(vehicleID), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getMaintenancesForVehicle', () {
    var eMaintenanceModels = <EMaintenanceModel>[];
    for (var j in json.decode(fixture('maintenances.json'))) {
      eMaintenanceModels.add(EMaintenanceModel.fromJson(j));
    }

    final vehicleID = 16;

    test(
      '''should perform a GET request on a URL /vehicles/{id}/trips''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200ForMaintenances();
        // act
        dataSource.getMaintenancesForVehicleID(vehicleID);
        // assert
        verify(mockHttpClient.get('https://sss.suma.guru/api/vehicles/${vehicleID}/maintenances'));
      },
    );

    test(
      'should return List<MaintenanceModel> when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200ForMaintenances();
        // act
        final result = await dataSource.getMaintenancesForVehicleID(vehicleID);
        // assert
        expect(result, equals(eMaintenanceModels));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getMaintenancesForVehicleID;
        // assert
        expect(() => call(vehicleID), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
