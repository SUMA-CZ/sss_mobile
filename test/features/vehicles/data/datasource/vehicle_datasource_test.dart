import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/datasources/vehicles_datasource.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_maintenance_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_refueling_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_trip_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/vehicle_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

const dioHttpHeadersForResponseBody = {
  Headers.contentTypeHeader: [Headers.jsonContentType],
};

void main() {
  final Dio dio = Dio();
  VehiclesRemoteDataSourceImpl dataSource;
  DioAdapterMock dioAdapterMock;

  setUp(() {
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    dataSource = VehiclesRemoteDataSourceImpl(client: dio);
  });

  void _setHTTP200WithJsonFile(String filename) {
    final responsePayload = fixture(filename);
    final httpResponse = ResponseBody.fromString(
      responsePayload,
      200,
      headers: dioHttpHeadersForResponseBody,
    );

    when(dioAdapterMock.fetch(any, any, any)).thenAnswer((_) async => httpResponse);
  }

  void setHTTP200Vehicles() {
    _setHTTP200WithJsonFile('vehicles.json');
  }

  void setHTTP200Trips() {
    _setHTTP200WithJsonFile('trips.json');
  }

  void setHTTP200Refueling() {
    _setHTTP200WithJsonFile('refuelings.json');
  }

  void setHTTP200Maintenances() {
    _setHTTP200WithJsonFile('maintenances.json');
  }

  void setHTTP400() {
    final responsePayload = json.encode({'error': 'error'});
    final httpResponse = ResponseBody.fromString(
      responsePayload,
      400,
      headers: dioHttpHeadersForResponseBody,
    );

    when(dioAdapterMock.fetch(any, any, any)).thenAnswer((_) async => httpResponse);
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
        setHTTP200Vehicles();
        // act
        dataSource.getVehicles();
        // assert
        // verify(mockHttpClient.get('https://sss.suma.guru/api/vehicles'));
      },
    );

    test(
      'should return List<Vehicles> when the response code is 200 (success)',
      () async {
        // arrange
        setHTTP200Vehicles();
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
        setHTTP400();
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
        setHTTP200Trips();
        // act
        dataSource.getTripsForVehicleID(vehicleID);
        // assert
        // verify(mockHttpClient.get('https://sss.suma.guru/api/vehicles/${vehicleID}/trips'));
      },
    );

    test(
      'should return List<TripModel> when the response code is 200 (success)',
      () async {
        // arrange
        setHTTP200Trips();
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
        setHTTP400();
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
        setHTTP200Refueling();
        // act
        dataSource.getRefuelingsForVehicleID(vehicleID);
        // assert
        // verify(mockHttpClient.get('https://sss.suma.guru/api/vehicles/${vehicleID}/refuelings'));
      },
    );

    test(
      'should return List<RefuelingModel> when the response code is 200 (success)',
      () async {
        // arrange
        setHTTP200Refueling();
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
        setHTTP400();
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
        setHTTP200Maintenances();
        // act
        dataSource.getMaintenancesForVehicleID(vehicleID);
        // assert
        // verify(dioAdapterMock.fetch('https://sss.suma.guru/api/vehicles/${vehicleID}/maintenances'));
      },
    );

    test(
      'should return List<MaintenanceModel> when the response code is 200 (success)',
      () async {
        // arrange
        setHTTP200Maintenances();
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
        setHTTP400();
        // act
        final call = dataSource.getMaintenancesForVehicleID;
        // assert
        expect(() => call(vehicleID), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
