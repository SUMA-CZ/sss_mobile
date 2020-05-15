import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/models/vehicle.dart';
import 'package:sss_mobile/repositories/vehicle_repo.dart';
import 'package:sss_mobile/vehicle_list/vehicle_list_event.dart';
import 'package:sss_mobile/vehicle_list/vehicle_list_state.dart';


class VehicleListBloc extends Bloc<VehicleListEvent, VehicleListState> {
  final VehicleRepository vehicleRepository;

  VehicleListBloc({@required this.vehicleRepository}) : assert(vehicleRepository != null);

  @override
  VehicleListState get initialState => VehicleListEmpty();

  @override
  Stream<VehicleListState> mapEventToState(VehicleListEvent event) async* {
    if (event is FetchVehiclesList) {
      yield VehicleListLoading();
      try {
        final List<Vehicle> vehicles = await vehicleRepository.updateVehicles();
        yield VehicleListLoaded(vehicles: vehicles);
      } catch (_) {
        yield VehicleListError();
      }
    }

    if (event is TestVehicleList) {
      yield VehicleListLoading();
      try {
        await Future.delayed(Duration(seconds: 2));
        yield VehicleListLoaded(vehicles: []);
      } catch (_) {
        yield VehicleListError();
      }
    }
  }
}
