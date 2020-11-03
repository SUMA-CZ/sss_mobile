import 'package:dartz/dartz.dart';
import 'package:sss_mobile/clean_architecture/core/error/failure.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_trip.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_vehicle.dart';

abstract class VehicleRepository {
  Future<Either<Failure, List<EVehicle>>> getVehicles();
  Future<Either<Failure, List<ETrip>>> getTripsForVehicles(int vehicleID);
}
