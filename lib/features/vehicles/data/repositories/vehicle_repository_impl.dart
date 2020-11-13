import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/vehicles_datasource.dart';
import 'package:sss_mobile/features/vehicles/data/models/maintenance_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class VehicleRepositoryImpl extends VehicleRepository {
  final VehiclesRemoteDataSource remoteDataSource;

  VehicleRepositoryImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Vehicle>>> getVehicles() async {
    try {
      final vehicleModels = await remoteDataSource.getVehicles();
      return Right(vehicleModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Maintenance>>> getMaintenancesForVehicleID(int vehicleID) async {
    try {
      final mainetenancesModels = await remoteDataSource.getMaintenancesForVehicleID(vehicleID);
      return Right(mainetenancesModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Refueling>>> getRefuelingsForVehicleID(int vehicleID) async {
    try {
      final refuelingModels = await remoteDataSource.getRefuelingsForVehicleID(vehicleID);
      return Right(refuelingModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Trip>>> getTripsForVehicleID(int vehicleID) async {
    try {
      final tripModels = await remoteDataSource.getTripsForVehicleID(vehicleID);
      return Right(tripModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Maintenance>>> createMaintenanceForVehicleID(
      int vehicleID, MaintenanceModel maintenance) async {
    // TODO: Fix this conversion fekal
    try {
      await remoteDataSource.createMaintenanceForVehicleID(vehicleID, maintenance);
      final mainetenancesModels = await remoteDataSource.getMaintenancesForVehicleID(vehicleID);
      return Right(mainetenancesModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Refueling>>> createRefuelingForVehicleID(
      int vehicleID, RefuelingModel refueling) async {
    try {
      await remoteDataSource.createRefuelingForVehicleID(vehicleID, refueling);
      final refuelingModels = await remoteDataSource.getRefuelingsForVehicleID(vehicleID);
      return Right(refuelingModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Trip>>> createTripForVehicleID(int vehicleID, TripModel trip) async {
    try {
      await remoteDataSource.createTripForVehicleID(vehicleID, trip);
      final trips = await remoteDataSource.getTripsForVehicleID(vehicleID);
      return Right(trips);
      return getTripsForVehicleID(vehicleID);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
