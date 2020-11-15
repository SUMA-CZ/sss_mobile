import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_vehicle.dart';

part 'vehicle_detail_state.dart';

class VehicleDetailCubit extends Cubit<VehicleDetailState> {
  VehicleDetailCubit({@required this.vehicle, @required this.usecase})
      : assert(vehicle != null && usecase != null),
        super(VehicleDetailStateInitial(vehicle: vehicle)) {
    emit(VehicleDetailStateInitial(vehicle: vehicle));
  }

  Vehicle vehicle;
  final ReadVehicle usecase;

  void readVehicle() async {
    emit(VehicleDetailStateLoading());
    emit((await usecase(Params(vehicleID: vehicle.id))).fold(
      (failure) => VehicleDetailStateInitial(vehicle: vehicle),
      (payload) {
        vehicle = payload;
        return VehicleDetailStateInitial(vehicle: payload);
      },
    ));
  }
}
