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

  Future<TripModel> createTripForVehicleID(int vehicleID, TripModel tripModel);

  Future<List<RefuelingModel>> getRefuelingsForVehicleID(int vehicleID);

  Future<RefuelingModel> createRefuelingForVehicleID(int vehicleID, RefuelingModel tripModel);

  Future<List<MaintenanceModel>> getMaintenancesForVehicleID(int vehicleID);

  Future<MaintenanceModel> createMaintenanceForVehicleID(int vehicleID, MaintenanceModel tripModel);
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

  @override
  Future<TripModel> createTripForVehicleID(int vehicleID, TripModel tripModel) =>
      _createTripForVehicleID('${EnvConfig.API_URL}/vehicles/$vehicleID/trips', tripModel.toJson());

  @override
  Future<MaintenanceModel> createMaintenanceForVehicleID(
          int vehicleID, MaintenanceModel tripModel) =>
      _createMaintenanceForVehicleID(
          '${EnvConfig.API_URL}/vehicles/$vehicleID/maintenances', tripModel.toJson());

  @override
  Future<RefuelingModel> createRefuelingForVehicleID(int vehicleID, RefuelingModel tripModel) =>
      _createRefuelingForVehicleID(
          '${EnvConfig.API_URL}/vehicles/$vehicleID/refuelings', tripModel.toJson());

  Future<RefuelingModel> _createRefuelingForVehicleID(
      String url, Map<String, dynamic> payload) async {
    try {
      return RefuelingModel.fromJson((await client.post(url, data: payload)).data);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<MaintenanceModel> _createMaintenanceForVehicleID(
      String url, Map<String, dynamic> payload) async {
    try {
      return MaintenanceModel.fromJson((await client.post(url, data: payload)).data);
    } catch (e) {
      throw ServerException();
    }
  }

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

  Future<TripModel> _createTripForVehicleID(String url, Map<String, dynamic> payload) async {
    try {
      return TripModel.fromJson((await client.post(url, data: payload)).data);
    } catch (e) {
      throw ServerException();
    }
  }
}
