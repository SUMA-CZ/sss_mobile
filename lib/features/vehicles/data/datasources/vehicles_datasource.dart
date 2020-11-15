import 'package:dio/dio.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/core/utils/comparators.dart';
import 'package:sss_mobile/features/vehicles/data/models/maintenance_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/vehicle_model.dart';

import '../../../../env_config.dart';

abstract class VehiclesRemoteDataSource {
  Future<List<VehicleModel>> getVehicles();

  Future<VehicleModel> getVehicle(int vehicleID);

  Future<List<TripModel>> getTripsForVehicleID(int vehicleID);

  Future<void> deleteTrip(int vehicleID, int tripID);
  Future<void> deleteMaintenance(int vehicleID, int maintenanceID);
  Future<void> deleteRefueling(int vehicleID, int refuelingID);

  Future<TripModel> createTripForVehicleID(int vehicleID, TripModel model);

  Future<List<RefuelingModel>> getRefuelingsForVehicleID(int vehicleID);

  Future<RefuelingModel> createRefuelingForVehicleID(int vehicleID, RefuelingModel model);

  Future<List<MaintenanceModel>> getMaintenancesForVehicleID(int vehicleID);

  Future<MaintenanceModel> createMaintenanceForVehicleID(int vehicleID, MaintenanceModel model);
}

class VehiclesRemoteDataSourceImpl implements VehiclesRemoteDataSource {
  final Dio client;

  VehiclesRemoteDataSourceImpl({this.client});

  @override
  Future<List<VehicleModel>> getVehicles() => _getVehiclesFromURL('${EnvConfig.API_URL}/vehicles');

  @override
  Future<VehicleModel> getVehicle(int vehicleID) =>
      _getVehicle('${EnvConfig.API_URL}/vehicles/${vehicleID}');

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
          int vehicleID, MaintenanceModel maintenanceModel) =>
      _createMaintenanceForVehicleID(
          '${EnvConfig.API_URL}/vehicles/$vehicleID/maintenances', maintenanceModel.toJson());

  @override
  Future<RefuelingModel> createRefuelingForVehicleID(
          int vehicleID, RefuelingModel refuelingModel) =>
      _createRefuelingForVehicleID(
          '${EnvConfig.API_URL}/vehicles/$vehicleID/refuelings', refuelingModel.toJson());

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
      var vehicles = <VehicleModel>[];
      final response = await client.get(url);
      for (var j in response.data) {
        vehicles.add(VehicleModel.fromJson(j));
      }
      return vehicles..sort(name);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<VehicleModel> _getVehicle(String url) async {
    try {
      final response = await client.get(url);
      return VehicleModel.fromJson(response.data);
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

  Future<List<RefuelingModel>> _getRefuelingsForVehicleID(String url) async {
    try {
      var refuelings = <RefuelingModel>[];
      final response = await client.get(url);
      for (var j in response.data) {
        refuelings.add(RefuelingModel.fromJson(j));
      }
      return refuelings..sort(refuelingOdoDescending);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<TripModel>> _getTripsForVehicleID(String url) async {
    try {
      var trips = <TripModel>[];
      final response = await client.get(url);

      for (var j in response.data) {
        trips.add(TripModel.fromJson(j));
      }
      return trips..sort(tripOdoDescending);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<MaintenanceModel>> _getMaintenancesForVehicleID(String url) async {
    try {
      var maintenances = <MaintenanceModel>[];
      final response = await client.get(url);
      for (var j in response.data) {
        maintenances.add(MaintenanceModel.fromJson(j));
      }
      return maintenances..sort(maintenanceDateDescending);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteTrip(int vehicleID, int tripID) async {
    try {
      await client.delete('${EnvConfig.API_URL}/vehicles/$vehicleID/trips/$tripID');
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteMaintenance(int vehicleID, int maintenanceID) async {
    try {
      await client.delete('${EnvConfig.API_URL}/vehicles/$vehicleID/maintenances/$maintenanceID');
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteRefueling(int vehicleID, int refuelingID) async {
    try {
      await client.delete('${EnvConfig.API_URL}/vehicles/$vehicleID/refuelings/$refuelingID');
    } catch (e) {
      throw ServerException();
    }
  }
}
