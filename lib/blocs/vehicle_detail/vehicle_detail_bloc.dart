import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/blocs/vehicle_detail/vehicle_detail.dart';
import 'package:sss_mobile/repositories/vehicle_repo.dart';

class VehicleDetailBloc extends Bloc<VehicleDetailEvent, VehicleDetailState> {
  final VehicleRepository vehicleRepository;

  VehicleDetailBloc({@required this.vehicleRepository}) : assert(vehicleRepository != null);

  @override
  VehicleDetailState get initialState => VehicleDetailLoading();

  @override
  Stream<VehicleDetailState> mapEventToState(VehicleDetailEvent event) async* {
    if (event is ShowVehicle) {
      yield VehicleDetailLoading();
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
