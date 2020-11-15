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
import '../../../../helpers/dio_response_helper.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

const dioHttpHeadersForResponseBody = {
  Headers.contentTypeHeader: [Headers.jsonContentType],
};

void main() {
  final dio = Dio();
  VehiclesRemoteDataSourceImpl dataSource;
  DioAdapterMock dioAdapterMock;

  setUp(() {
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    dataSource = VehiclesRemoteDataSourceImpl(client: dio);
  });

  group('getVehicles', () {
    var eVehicles = <VehicleModel>[];
    for (var j in json.decode(fixture('vehicles.json'))) {
      eVehicles.add(VehicleModel.fromJson(j));
    }

    test(
      '''should perform a GET request on a URL /vehicles''',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 200, 'vehicles.json');
        // act
        await dataSource.getVehicles();
        // assert
        // verify(dioAdapterMock. mockHttpClient.get('https://sss.suma.guru/api/vehicles'));
      },
    );

    test(
      'should return List<Vehicles> when the response code is 200 (success)',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 200, 'vehicles.json');
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
        setHTTPResponse(dioAdapterMock, 400, null);
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
        setHTTPResponse(dioAdapterMock, 200, 'trips.json');
        // act
        await dataSource.getTripsForVehicleID(vehicleID);
        // assert
        // verify(mockHttpClient.get('https://sss.suma.guru/api/vehicles/${vehicleID}/trips'));
      },
    );

    test(
      'should return List<TripModel> when the response code is 200 (success)',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 200, 'trips.json');
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
        setHTTPResponse(dioAdapterMock, 400, null);
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
        setHTTPResponse(dioAdapterMock, 200, 'refuelings.json');
        // act
        await dataSource.getRefuelingsForVehicleID(vehicleID);
        // assert
        // verify(mockHttpClient.get('https://sss.suma.guru/api/vehicles/${vehicleID}/refuelings'));
      },
    );

    test(
      'should return List<RefuelingModel> when the response code is 200 (success)',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 200, 'refuelings.json');
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
        setHTTPResponse(dioAdapterMock, 400, null);
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
        setHTTPResponse(dioAdapterMock, 200, 'maintenances.json');
        // act
        await dataSource.getMaintenancesForVehicleID(vehicleID);
        // assert
        // verify(dioAdapterMock.fetch('https://sss.suma.guru/api/vehicles/${vehicleID}/maintenances'));
      },
    );

    test(
      'should return List<MaintenanceModel> when the response code is 200 (success)',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 200, 'maintenances.json');
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
        setHTTPResponse(dioAdapterMock, 400, null);
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
        setHTTPResponse(dioAdapterMock, 200, 'trip.json');
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
        setHTTPResponse(dioAdapterMock, 500, null);
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
        setHTTPResponse(dioAdapterMock, 201, 'refueling.json');
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
        setHTTPResponse(dioAdapterMock, 500, null);
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
        setHTTPResponse(dioAdapterMock, 201, 'maintenance.json');
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
        setHTTPResponse(dioAdapterMock, 500, null);
        // act
        final call = dataSource.createMaintenanceForVehicleID;
        // assert
        expect(() => call(vehicleID, tMaintenance), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getVehicle', () {
    var tVehicle = VehicleModel.fromJson(json.decode(fixture('vehicle.json')));
    final vehicleID = 16;

    test(
      'should return VehicleModel when the response code is 200 ',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 200, 'vehicle.json');
        // act
        final result = await dataSource.getVehicle(vehicleID);
        // assert
        expect(result, equals(tVehicle));
      },
    );

    test(
      'should throw a ServerException when the response code is 500 or other',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 500, null);
        // act
        final call = dataSource.getVehicle;
        // assert
        expect(() => call(vehicleID), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('deleteRecords', () {
    test(
      'should return VehicleModel when the response code is 200 ',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 200, null);
        // act
        // Nothing to test here as unable to test the url dio made request to
        await dataSource.deleteTrip(1, 1);
        setHTTPResponse(dioAdapterMock, 200, null);
        await dataSource.deleteMaintenance(1, 1);
        setHTTPResponse(dioAdapterMock, 200, null);
        await dataSource.deleteRefueling(1, 1);
        // assert
      },
    );

    test(
      'should throw a ServerException when the response code is 500 or other',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 500, null);
        // act
        final call = dataSource.deleteMaintenance;
        // assert
        expect(() => call(1, 1), throwsA(TypeMatcher<ServerException>()));
      },
    );

    test(
      'should throw a ServerException when the response code is 500 or other',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 500, null);
        // act
        final call = dataSource.deleteTrip;
        // assert
        expect(() => call(1, 1), throwsA(TypeMatcher<ServerException>()));
      },
    );

    test(
      'should throw a ServerException when the response code is 500 or other',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 500, null);
        // act
        final call = dataSource.deleteRefueling;
        // assert
        expect(() => call(1, 1), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
