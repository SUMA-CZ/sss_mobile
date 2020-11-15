import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/models/maintenance_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';

abstract class VehicleRepository {
  Future<Either<Failure, List<Vehicle>>> getVehicles();
  Future<Either<Failure, Vehicle>> getVehicle(int vehicleID);
  Future<Either<Failure, void>> deleteTrip(int vehicleID, int tripID);
  Future<Either<Failure, void>> deleteMaintenance(int vehicleID, int maintenanceID);
  Future<Either<Failure, void>> deleteRefueling(int vehicleID, int refuelingID);
  Future<Either<Failure, List<Trip>>> getTripsForVehicleID(int vehicleID);
  Future<Either<Failure, List<Refueling>>> getRefuelingsForVehicleID(int vehicleID);
  Future<Either<Failure, List<Maintenance>>> getMaintenancesForVehicleID(int vehicleID);

  Future<Either<Failure, List<Trip>>> createTripForVehicleID(int vehicleID, TripModel trip);
  Future<Either<Failure, List<Refueling>>> createRefuelingForVehicleID(
      int vehicleID, RefuelingModel refueling);
  Future<Either<Failure, List<Maintenance>>> createMaintenanceForVehicleID(
      int vehicleID, MaintenanceModel maintenance);
}
