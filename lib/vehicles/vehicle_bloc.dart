import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/models/vehicle.dart';
import 'package:sss_mobile/repositories/vehicle_repo.dart';
import 'package:sss_mobile/vehicles/vehicle_event.dart';
import 'package:sss_mobile/vehicles/vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleRepository vehicleRepository;

  VehicleBloc({@required this.vehicleRepository}) : assert(vehicleRepository != null);

  @override
  VehicleState get initialState => VehicleEmpty();

  @override
  Stream<VehicleState> mapEventToState(VehicleEvent event) async* {
    if (event is FetchVehicles) {
      yield VehicleLoading();
      try {
        final List<Vehicle> vehicles = await vehicleRepository.updateVehicles();
        yield VehicleLoaded(vehicles: vehicles);
      } catch (_) {
        yield VehicleError();
      }
    }

    if (event is TESTEvent) {
      yield VehicleLoading();
      try {
        await Future.delayed(Duration(seconds: 2));
        yield VehicleLoaded(vehicles: []);
      } catch (_) {
        yield VehicleError();
      }
    }
  }
}
