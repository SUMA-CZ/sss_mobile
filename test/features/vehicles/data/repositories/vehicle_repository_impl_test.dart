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
  var eVehiclesModel = <VehicleModel>[];
  for (var j in json.decode(fixture('vehicles.json'))) {
    eVehiclesModel.add(VehicleModel.fromJson(j));
  }

  var eMaintenanceModels = <MaintenanceModel>[];
  for (var j in json.decode(fixture('maintenances.json'))) {
    eMaintenanceModels.add(MaintenanceModel.fromJson(j));
  }

  var eRefuelingModels = <RefuelingModel>[];
  for (var j in json.decode(fixture('refuelings.json'))) {
    eRefuelingModels.add(RefuelingModel.fromJson(j));
  }

  var eTripsModel = <TripModel>[];
  for (var j in json.decode(fixture('trips.json'))) {
    eTripsModel.add(TripModel.fromJson(j));
  }

  var vehicleID = 16;

  group('getVehicles', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getVehicles()).thenAnswer((_) async => eVehiclesModel);
        // act
        final result = await repository.getVehicles();
        // assert
        verify(mockRemoteDataSource.getVehicles());
        expect(result, equals(Right(eVehiclesModel)));
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
            .thenAnswer((_) async => eTripsModel);
        // act
        final result = await repository.getTripsForVehicleID(vehicleID);
        // assert
        verify(mockRemoteDataSource.getTripsForVehicleID(vehicleID));
        expect(result, equals(Right(eTripsModel)));
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
            .thenAnswer((_) async => eRefuelingModels);
        // act
        final result = await repository.getRefuelingsForVehicleID(vehicleID);
        // assert
        verify(mockRemoteDataSource.getRefuelingsForVehicleID(vehicleID));
        expect(result, equals(Right(eRefuelingModels)));
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
            .thenAnswer((_) async => eMaintenanceModels);
        // act
        final result = await repository.getMaintenancesForVehicleID(vehicleID);
        // assert
        verify(mockRemoteDataSource.getMaintenancesForVehicleID(vehicleID));
        expect(result, equals(Right(eMaintenanceModels)));
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
}
