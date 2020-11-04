import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';
import 'package:sss_mobile/clean_architecture/core/error/failure.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/datasources/vehicles_datasource.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_maintenance_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_refueling_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_trip_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/vehicle_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/repositories/vehicle_repository_impl.dart';

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

  var eMaintenanceModels = <EMaintenanceModel>[];
  for (var j in json.decode(fixture('maintenances.json'))) {
    eMaintenanceModels.add(EMaintenanceModel.fromJson(j));
  }

  var eRefuelingModels = <ERefuelingModel>[];
  for (var j in json.decode(fixture('refuelings.json'))) {
    eRefuelingModels.add(ERefuelingModel.fromJson(j));
  }

  var eTripsModel = <ETripModel>[];
  for (var j in json.decode(fixture('trips.json'))) {
    eTripsModel.add(ETripModel.fromJson(j));
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
