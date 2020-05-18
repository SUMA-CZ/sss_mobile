import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss_mobile/models/maintenance.dart';
import 'package:sss_mobile/models/refueling.dart';
import 'package:sss_mobile/models/trip.dart';
import 'package:sss_mobile/models/vehicle.dart';

import '../networking/env.dart';

class AuthInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = (prefs.getString('token') ?? "");
      if (token == "") {
        // TODO: fix me
        print("Navigate to login screen");
      }
      data.headers["Authorization"] = "Bearer $token";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async => data;
}

class VehicleAPI {
  Client client = HttpClientWithInterceptor.build(interceptors: [
    AuthInterceptor(),
  ]);

  Future<Trip> saveTrip(Vehicle vehicle, Trip trip) async {
    try {
      if (trip.id != null) {
        final response =
        await client.put("${environment['baseUrl']}/vehicles/${vehicle.id}/trips/${trip.id}", headers: {'Content-type': 'application/json', 'Accept': 'application/json'}, body: vehicle.toJson());
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          return Trip.fromJson(json);
        } else {
          throw Exception("Error saving. \n ${response.body}");
        }
      } else {
        final response = await client.post(
            "${environment['baseUrl']}/vehicles/${vehicle.id}/trips", headers: {'Content-type': 'application/json', 'Accept': 'application/json', "Authorization": "Some token"},
            body: json.encode(trip.toJson()));
        if (response.statusCode == 201) {
          final json = jsonDecode(response.body);
          return Trip.fromJson(json);
        } else {
          throw Exception("Error saving. \n ${response.body}");
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Vehicle>> fetchVehicles() async {
    var vehicles = <Vehicle>[];
    try {
      final response = await client.get("${environment['baseUrl']}/vehicles");
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        for (var j in json) {
          vehicles.add(Vehicle.fromJson(j));
        }
      } else {
        throw Exception("Error while fetching. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return vehicles;
  }

  Future<List<Maintenance>> fetchMaintenancesFor(Vehicle vehicle) async {
    var maintenances = <Maintenance>[];
    try {
      final response = await client.get("${environment['baseUrl']}/vehicles/${vehicle.id}/maintenances");
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        for (var j in json) {
          maintenances.add(Maintenance.fromJson(j));
        }
      } else {
        throw Exception("Error while fetching. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return maintenances;
  }

  Future<List<Refueling>> fetchRefuelingsFor(Vehicle vehicle) async {
    var data = <Refueling>[];
    try {
      final response = await client.get("${environment['baseUrl']}/vehicles/${vehicle.id}/refuelings");
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        for (var j in json) {
          data.add(Refueling.fromJson(j));
        }
      } else {
        throw Exception("Error while fetching. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return data;
  }

  Future<List<Trip>> fetchTripsFor(Vehicle vehicle) async {
    var data = <Trip>[];
    try {
      final response = await client.get("${environment['baseUrl']}/vehicles/${vehicle.id}/trips");
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        for (var j in json) {
          data.add(Trip.fromJson(j));
        }
      } else {
        throw Exception("Error while fetching. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return data;
  }

}
