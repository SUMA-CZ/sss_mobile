import 'package:dio/dio.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/features/vehicles/data/models/e_maintenance_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/e_refueling_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/e_trip_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/vehicle_model.dart';

abstract class VehiclesRemoteDataSource {
  Future<List<VehicleModel>> getVehicles();

  Future<List<ETripModel>> getTripsForVehicleID(int vehicleID);

  Future<List<ERefuelingModel>> getRefuelingsForVehicleID(int vehicleID);

  Future<List<EMaintenanceModel>> getMaintenancesForVehicleID(int vehicleID);
}

class VehiclesRemoteDataSourceImpl implements VehiclesRemoteDataSource {
  final Dio client;

  VehiclesRemoteDataSourceImpl({this.client});

  @override
  Future<List<VehicleModel>> getVehicles() =>
      _getVehiclesFromURL('https://sss.suma.guru/api/vehicles');

  @override
  Future<List<EMaintenanceModel>> getMaintenancesForVehicleID(int vehicleID) =>
      _getMaintenancesForVehicleID('https://sss.suma.guru/api/vehicles/$vehicleID/maintenances');

  @override
  Future<List<ERefuelingModel>> getRefuelingsForVehicleID(int vehicleID) =>
      _getRefuelingsForVehicleID('https://sss.suma.guru/api/vehicles/$vehicleID/refuelings');

  @override
  Future<List<ETripModel>> getTripsForVehicleID(int vehicleID) =>
      _getTripsForVehicleID('https://sss.suma.guru/api/vehicles/$vehicleID/trips');

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

  Future<List<ERefuelingModel>> _getRefuelingsForVehicleID(String url) async {
    try {
      List<ERefuelingModel> refuelings = <ERefuelingModel>[];
      final response = await client.get(url);
      for (var j in response.data) {
        refuelings.add(ERefuelingModel.fromJson(j));
      }
      return refuelings;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<ETripModel>> _getTripsForVehicleID(String url) async {
    try {
      List<ETripModel> trips = <ETripModel>[];
      final response = await client.get(url);

      for (var j in response.data) {
        trips.add(ETripModel.fromJson(j));
      }
      return trips;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<EMaintenanceModel>> _getMaintenancesForVehicleID(String url) async {
    try {
      List<EMaintenanceModel> maintenances = <EMaintenanceModel>[];
      final response = await client.get(url);
      for (var j in response.data) {
        maintenances.add(EMaintenanceModel.fromJson(j));
      }
      return maintenances;
    } catch (e) {
      throw ServerException();
    }
  }
}
