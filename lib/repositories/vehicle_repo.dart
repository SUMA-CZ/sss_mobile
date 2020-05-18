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
    for (Vehicle vehicle in vehicles) {
      vehicle.trips = await vehicleAPI.fetchTripsFor(vehicle);
      vehicle.refueling = await vehicleAPI.fetchRefuelingsFor(vehicle);
      vehicle.maintenance = await vehicleAPI.fetchMaintenancesFor(vehicle);
    }

    return this.vehicles;
  }
}
