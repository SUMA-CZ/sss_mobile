import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';

abstract class VehicleRepository {
  Future<Either<Failure, List<Vehicle>>> getVehicles();
  Future<Either<Failure, List<Trip>>> getTripsForVehicleID(int vehicleID);
  Future<Either<Failure, List<Refueling>>> getRefuelingsForVehicleID(int vehicleID);
  Future<Either<Failure, List<Maintenance>>> getMaintenancesForVehicleID(int vehicleID);

  Future<Either<Failure, List<Trip>>> createTripForVehicleID(int vehicleID, Trip trip);
  Future<Either<Failure, List<Refueling>>> createRefuelingForVehicleID(
      int vehicleID, Refueling refueling);
  Future<Either<Failure, List<Maintenance>>> createMaintenanceForVehicleID(
      int vehicleID, Maintenance maintenance);
}
