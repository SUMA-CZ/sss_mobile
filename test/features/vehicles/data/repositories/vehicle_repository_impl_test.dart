import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/vehicles_datasource.dart';
import 'package:sss_mobile/features/vehicles/data/models/maintenance_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/vehicle_model.dart';
import 'package:sss_mobile/features/vehicles/data/repositories/vehicle_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements VehiclesRemoteDataSource {}

void main() {
  VehicleRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = VehicleRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  // TODO: Refactor
  var tVehiclesModel = <VehicleModel>[];
  for (var j in json.decode(fixture('vehicles.json'))) {
    tVehiclesModel.add(VehicleModel.fromJson(j));
  }

  var tMaintenanceModels = <MaintenanceModel>[];
  for (var j in json.decode(fixture('maintenances.json'))) {
    tMaintenanceModels.add(MaintenanceModel.fromJson(j));
  }

  var tRefuelingModels = <RefuelingModel>[];
  for (var j in json.decode(fixture('refuelings.json'))) {
    tRefuelingModels.add(RefuelingModel.fromJson(j));
  }

  var tTripsModel = <TripModel>[];
  for (var j in json.decode(fixture('trips.json'))) {
    tTripsModel.add(TripModel.fromJson(j));
  }

  final tOneTripModel = TripModel.fromJson(json.decode(fixture('trip.json')));
  final tOneRefuelingModel = RefuelingModel.fromJson(json.decode(fixture('refueling.json')));
  final tOneMaintenanceModel = MaintenanceModel.fromJson(json.decode(fixture('maintenance.json')));

  var vehicleID = 16;

  group('getVehicles', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getVehicles()).thenAnswer((_) async => tVehiclesModel);
        // act
        final result = await repository.getVehicles();
        // assert
        verify(mockRemoteDataSource.getVehicles());
        expect(result, equals(Right(tVehiclesModel)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getVehicles()).thenThrow(ServerException());
        // act
        final result = await repository.getVehicles();
        // assert
        verify(mockRemoteDataSource.getVehicles());
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('getTripsForVehicleID', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTripsForVehicleID(vehicleID))
            .thenAnswer((_) async => tTripsModel);
        // act
        final result = await repository.getTripsForVehicleID(vehicleID);
        // assert
        verify(mockRemoteDataSource.getTripsForVehicleID(vehicleID));
        expect(result, equals(Right(tTripsModel)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTripsForVehicleID(vehicleID)).thenThrow(ServerException());
        // act
        final result = await repository.getTripsForVehicleID(vehicleID);
        // assert
        verify(mockRemoteDataSource.getTripsForVehicleID(vehicleID));
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('getRefuelingForVehicleID', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getRefuelingsForVehicleID(vehicleID))
            .thenAnswer((_) async => tRefuelingModels);
        // act
        final result = await repository.getRefuelingsForVehicleID(vehicleID);
        // assert
        verify(mockRemoteDataSource.getRefuelingsForVehicleID(vehicleID));
        expect(result, equals(Right(tRefuelingModels)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getRefuelingsForVehicleID(vehicleID))
            .thenThrow(ServerException());
        // act
        final result = await repository.getRefuelingsForVehicleID(vehicleID);
        // assert
        verify(mockRemoteDataSource.getRefuelingsForVehicleID(vehicleID));
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('getMaintenancesForVehicleID', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMaintenancesForVehicleID(vehicleID))
            .thenAnswer((_) async => tMaintenanceModels);
        // act
        final result = await repository.getMaintenancesForVehicleID(vehicleID);
        // assert
        verify(mockRemoteDataSource.getMaintenancesForVehicleID(vehicleID));
        expect(result, equals(Right(tMaintenanceModels)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMaintenancesForVehicleID(vehicleID))
            .thenThrow(ServerException());
        // act
        final result = await repository.getMaintenancesForVehicleID(vehicleID);
        // assert
        verify(mockRemoteDataSource.getMaintenancesForVehicleID(vehicleID));
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('createTrip', () {
    var id = 1;
    test(
      'should call create and get on datasource',
      () async {
        final result = repository.createTripForVehicleID(id, tOneTripModel);
        verify(mockRemoteDataSource.createTripForVehicleID(any, any));
      },
    );
  });

  group('createMaintenance', () {
    var id = 1;
    test(
      'should call create and get on datasource',
      () async {
        repository.createMaintenanceForVehicleID(id, tOneMaintenanceModel);
        verify(mockRemoteDataSource.createMaintenanceForVehicleID(id, tOneMaintenanceModel));
      },
    );
  });

  group('createRefueling', () {
    var id = 1;
    test(
      'should call create and get on datasource',
      () async {
        repository.createRefuelingForVehicleID(id, tOneRefuelingModel);
        verify(mockRemoteDataSource.createRefuelingForVehicleID(id, tOneRefuelingModel));
      },
    );
  });
}
