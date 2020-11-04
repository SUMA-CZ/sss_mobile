import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_maintenance_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_refueling_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_trip_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/vehicle_model.dart';

abstract class VehiclesRemoteDataSource {
  Future<List<VehicleModel>> getVehicles();

  Future<List<ETripModel>> getTripsForVehicleID(int vehicleID);

  Future<List<ERefuelingModel>> getRefuelingsForVehicleID(int vehicleID);

  Future<List<EMaintenanceModel>> getMaintenancesForVehicleID(int vehicleID);
}

class VehiclesRemoteDataSourceImpl implements VehiclesRemoteDataSource {
  final http.Client client;

  VehiclesRemoteDataSourceImpl({this.client});

  @override
  Future<List<VehicleModel>> getVehicles() =>
      _getVehiclesFromURL('https://sss.suma.guru/api/vehicles');

  @override
  Future<List<EMaintenanceModel>> getMaintenancesForVehicleID(int vehicleID) =>
      _getMaintenancesForVehicleID('https://sss.suma.guru/api/vehicles/${vehicleID}/maintenances');

  @override
  Future<List<ERefuelingModel>> getRefuelingsForVehicleID(int vehicleID) =>
      _getRefuelingsForVehicleID('https://sss.suma.guru/api/vehicles/${vehicleID}/refuelings');

  @override
  Future<List<ETripModel>> getTripsForVehicleID(int vehicleID) =>
      _getTripsForVehicleID('https://sss.suma.guru/api/vehicles/${vehicleID}/trips');

  Future<List<VehicleModel>> _getVehiclesFromURL(String url) async {
    List<VehicleModel> vehicles = <VehicleModel>[];
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      for (var j in json) {
        vehicles.add(VehicleModel.fromJson(j));
      }
    } else {
      throw ServerException();
    }

    return vehicles;
  }

  Future<List<ERefuelingModel>> _getRefuelingsForVehicleID(String url) async {
    List<ERefuelingModel> refuelings = <ERefuelingModel>[];
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      for (var j in json) {
        refuelings.add(ERefuelingModel.fromJson(j));
      }
    } else {
      throw ServerException();
    }

    return refuelings;
  }

  Future<List<ETripModel>> _getTripsForVehicleID(String url) async {
    List<ETripModel> trips = <ETripModel>[];
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      for (var j in json) {
        trips.add(ETripModel.fromJson(j));
      }
    } else {
      throw ServerException();
    }

    return trips;
  }

  Future<List<EMaintenanceModel>> _getMaintenancesForVehicleID(String url) async {
    List<EMaintenanceModel> maintenances = <EMaintenanceModel>[];
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      for (var j in json) {
        maintenances.add(EMaintenanceModel.fromJson(j));
      }
    } else {
      throw ServerException();
    }

    return maintenances;
  }
}
