import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_trip_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/vehicle_model.dart';

abstract class VehiclesRemoteDataSource {
  Future<List<VehicleModel>> getVehicles();
  Future<List<ETripModel>> getTripsForVehicleID(int vehicleID);
  Future<List<ETripModel>> getRefuelingsForVehicleID(int vehicleID);
  Future<List<ETripModel>> getMaintenancesForVehicleID(int vehicleID);
}

class VehiclesRemoteDataSourceImpl implements VehiclesRemoteDataSource {
  final http.Client client;

  VehiclesRemoteDataSourceImpl({this.client});

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

  @override
  Future<List<VehicleModel>> getVehicles() =>
      _getVehiclesFromURL('https://sss.suma.guru/api/vehicles');

  @override
  Future<List<ETripModel>> getMaintenancesForVehicleID(int vehicleID) {
    // TODO: implement getMaintenancesForVehicleID
    return null;
  }

  @override
  Future<List<ETripModel>> getRefuelingsForVehicleID(int vehicleID) {
    // TODO: implement getRefuelingsForVehicleID
    return null;
  }

  @override
  Future<List<ETripModel>> getTripsForVehicleID(int vehicleID) {
    // TODO: implement getTripsForVehicleID
    return null;
  }
}
