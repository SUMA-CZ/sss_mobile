import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';

import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/vehicle_model.dart';

abstract class VehiclesRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<VehicleModel>> getVehicles();

/// Calls the http://numbersapi.com/random endpoint.
///
/// Throws a [ServerException] for all error codes.
// Future<TripModel> getTripsForVehicle(int vehicleID);
}

class VehiclesRemoteDataSourceImpl implements VehiclesRemoteDataSource {
  final http.Client client;

  VehiclesRemoteDataSourceImpl(this.client);


  Future<List<VehicleModel>> _getVehiclesFromURL(String url) async {
    var vehicles = <VehicleModel>[];
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
  Future<List<VehicleModel>> getVehicles() => _getVehiclesFromURL('https://sss.suma.guru/api/vehicles');
}

