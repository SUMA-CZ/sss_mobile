import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:sss_mobile/networking/vehicle_factory.dart';

import 'env.dart';

class VehicleAPI {
  Client client = HttpClientWithInterceptor.build();

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
}