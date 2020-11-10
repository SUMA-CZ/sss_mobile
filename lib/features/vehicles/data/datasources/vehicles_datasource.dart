import 'package:dio/dio.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/features/vehicles/data/models/maintenance_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/vehicle_model.dart';

import '../../../../env_config.dart';

abstract class VehiclesRemoteDataSource {
  Future<List<VehicleModel>> getVehicles();

  Future<List<TripModel>> getTripsForVehicleID(int vehicleID);

  Future<List<RefuelingModel>> getRefuelingsForVehicleID(int vehicleID);

  Future<List<MaintenanceModel>> getMaintenancesForVehicleID(int vehicleID);
}

class VehiclesRemoteDataSourceImpl implements VehiclesRemoteDataSource {
  final Dio client;

  VehiclesRemoteDataSourceImpl({this.client});

  @override
  Future<List<VehicleModel>> getVehicles() => _getVehiclesFromURL('${EnvConfig.API_URL}/vehicles');

  @override
  Future<List<MaintenanceModel>> getMaintenancesForVehicleID(int vehicleID) =>
      _getMaintenancesForVehicleID('${EnvConfig.API_URL}/vehicles/$vehicleID/maintenances');

  @override
  Future<List<RefuelingModel>> getRefuelingsForVehicleID(int vehicleID) =>
      _getRefuelingsForVehicleID('${EnvConfig.API_URL}/vehicles/$vehicleID/refuelings');

  @override
  Future<List<TripModel>> getTripsForVehicleID(int vehicleID) =>
      _getTripsForVehicleID('${EnvConfig.API_URL}/vehicles/$vehicleID/trips');

  Future<List<VehicleModel>> _getVehiclesFromURL(String url) async {
    try {
      List<VehicleModel> vehicles = <VehicleModel>[];
      final response = await client.get(url);
      for (var j in response.data) {
        vehicles.add(VehicleModel.fromJson(j));
      }
      return vehicles;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<RefuelingModel>> _getRefuelingsForVehicleID(String url) async {
    try {
      List<RefuelingModel> refuelings = <RefuelingModel>[];
      final response = await client.get(url);
      for (var j in response.data) {
        refuelings.add(RefuelingModel.fromJson(j));
      }
      return refuelings;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<TripModel>> _getTripsForVehicleID(String url) async {
    try {
      List<TripModel> trips = <TripModel>[];
      final response = await client.get(url);

      for (var j in response.data) {
        trips.add(TripModel.fromJson(j));
      }
      return trips;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<MaintenanceModel>> _getMaintenancesForVehicleID(String url) async {
    try {
      List<MaintenanceModel> maintenances = <MaintenanceModel>[];
      final response = await client.get(url);
      for (var j in response.data) {
        maintenances.add(MaintenanceModel.fromJson(j));
      }
      return maintenances;
    } catch (e) {
      throw ServerException();
    }
  }
}
