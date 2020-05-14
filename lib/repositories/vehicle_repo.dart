import 'package:meta/meta.dart';
import 'package:sss_mobile/apis/vehicle_api.dart';
import 'package:sss_mobile/models/vehicle.dart';

class VehicleRepository {
  List<Vehicle> vehicles = <Vehicle>[];
  static const KEY = 'TOKEN';

  final VehicleAPI vehicleAPI;

  VehicleRepository({@required this.vehicleAPI}) : assert(vehicleAPI != null);

  Future<List<Vehicle>> updateVehicles() async {
    this.vehicles = await vehicleAPI.fetchVehicles();
    this.vehicles.forEach((element) async {
      element.trips = await vehicleAPI.fetchTripsFor(element);
    });

    this.vehicles.forEach((element) async {
      element.refueling = await vehicleAPI.fetchRefuelingsFor(element);
    });

    this.vehicles.forEach((element) async {
      element.maintenance = await vehicleAPI.fetchMaintenancesFor(element);
    });

    return this.vehicles;
  }
}
