import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';
import 'package:sss_mobile/clean_architecture/core/error/failure.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/datasources/vehicles_datasource.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_maintenance.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_refueling.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_trip.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_vehicle.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/repositories/vehicle_repository.dart';

class VehicleRepositoryImpl extends VehicleRepository {
  final VehiclesRemoteDataSource remoteDataSource;

  VehicleRepositoryImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failure, List<EVehicle>>> getVehicles() async {
    try {
      final vehicleModels = await remoteDataSource.getVehicles();
      return Right(vehicleModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<EMaintenance>>> getMaintenancesForVehicleID(int vehicleID) async {
    try {
      final mainetenancesModels = await remoteDataSource.getMaintenancesForVehicleID(vehicleID);
      return Right(mainetenancesModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ERefueling>>> getRefuelingsForVehicleID(int vehicleID) async {
    try {
      final refuelingModels = await remoteDataSource.getRefuelingsForVehicleID(vehicleID);
      return Right(refuelingModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ETrip>>> getTripsForVehicleID(int vehicleID) async {
    try {
      final tripModels = await remoteDataSource.getTripsForVehicleID(vehicleID);
      return Right(tripModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
