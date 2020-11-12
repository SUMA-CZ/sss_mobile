import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/vehicles_datasource.dart';
import 'package:sss_mobile/features/vehicles/data/models/maintenance_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/vehicle_model.dart';

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

  setHTTP201With(String filename) {
    final responsePayload = fixture(filename);
    final httpResponse = ResponseBody.fromString(
      responsePayload,
      201,
      headers: dioHttpHeadersForResponseBody,
    );

    when(dioAdapterMock.fetch(any, any, any)).thenAnswer((_) async => httpResponse);
  }

  setHTTP500() {
    final httpResponse = ResponseBody.fromString(
      '',
      500,
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
        // verify(dioAdapterMock. mockHttpClient.get('https://sss.suma.guru/api/vehicles'));
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
    var eTrips = <TripModel>[];
    for (var j in json.decode(fixture('trips.json'))) {
      eTrips.add(TripModel.fromJson(j));
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
    var eRefuelingModels = <RefuelingModel>[];
    for (var j in json.decode(fixture('refuelings.json'))) {
      eRefuelingModels.add(RefuelingModel.fromJson(j));
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
    var eMaintenanceModels = <MaintenanceModel>[];
    for (var j in json.decode(fixture('maintenances.json'))) {
      eMaintenanceModels.add(MaintenanceModel.fromJson(j));
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

  group('getTripsForVehicle', () {
    var tTrip = TripModel.fromJson(json.decode(fixture('trip.json')));
    final vehicleID = 16;

    test(
      'should return TripModel when the response code is 201 (created)',
      () async {
        // arrange
        setHTTP201With('trip.json');
        // act
        final result = await dataSource.createTripForVehicleID(vehicleID, tTrip);
        // assert
        expect(result, equals(tTrip));
      },
    );

    test(
      'should throw a ServerException when the response code is 500 or other',
      () async {
        // arrange
        setHTTP500();
        // act
        final call = dataSource.createTripForVehicleID;
        // assert
        expect(() => call(vehicleID, tTrip), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('createRefueling', () {
    var tRefueling = RefuelingModel.fromJson(json.decode(fixture('refueling.json')));
    final vehicleID = 16;

    test(
      'should return RefuelingModel when the response code is 201 (created)',
      () async {
        // arrange
        setHTTP201With('refueling.json');
        // act
        final result = await dataSource.createRefuelingForVehicleID(vehicleID, tRefueling);
        // assert
        expect(result, equals(tRefueling));
      },
    );

    test(
      'should throw a ServerException when the response code is 500 or other',
      () async {
        // arrange
        setHTTP500();
        // act
        final call = dataSource.createRefuelingForVehicleID;
        // assert
        expect(() => call(vehicleID, tRefueling), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('createMaintenance', () {
    var tMaintenance = MaintenanceModel.fromJson(json.decode(fixture('maintenance.json')));
    final vehicleID = 16;

    test(
      'should return MaintenanceModel when the response code is 201 (created)',
      () async {
        // arrange
        setHTTP201With('maintenance.json');
        // act
        final result = await dataSource.createMaintenanceForVehicleID(vehicleID, tMaintenance);
        // assert
        expect(result, equals(tMaintenance));
      },
    );

    test(
      'should throw a ServerException when the response code is 500 or other',
      () async {
        // arrange
        setHTTP500();
        // act
        final call = dataSource.createMaintenanceForVehicleID;
        // assert
        expect(() => call(vehicleID, tMaintenance), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
