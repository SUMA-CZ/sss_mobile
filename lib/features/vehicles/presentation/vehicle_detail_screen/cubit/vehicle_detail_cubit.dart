import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_vehicle.dart';

part 'vehicle_detail_state.dart';

class VehicleDetailCubit extends Cubit<VehicleDetailState> {
  VehicleDetailCubit({@required this.vehicle, @required this.usecase})
      : assert(vehicle != null && usecase != null),
        super(VehicleDetailInitial(vehicle: vehicle)) {
    emit(VehicleDetailInitial(vehicle: vehicle));
  }

  Vehicle vehicle;
  final GetVehicle usecase;

  void getVehicle() async {
    emit(VehicleDetailLoading());
    emit((await usecase(Params(vehicleID: vehicle.id))).fold(
      (failure) => VehicleDetailInitial(vehicle: vehicle),
      (payload) {
        vehicle = payload;
        return VehicleDetailInitial(vehicle: payload);
      },
    ));
  }
}
