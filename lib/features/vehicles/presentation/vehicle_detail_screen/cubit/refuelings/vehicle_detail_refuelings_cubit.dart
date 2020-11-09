import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_refuelings_for_vehicle.dart';

part 'vehicle_detail_refuelings_state.dart';

class VehicleDetailRefuelingsCubit extends Cubit<VehicleDetailRefuelingsState> {
  VehicleDetailRefuelingsCubit({this.usecase, this.vehicle})
      : assert(usecase != null, vehicle != null),
        super(VehicleDetailRefuelingsInitial());

  final GetRefuelingsForVehicle usecase;
  final Vehicle vehicle;

  void getRefuelings() async {
    emit(VehicleDetailRefuelingsLoading());
    emit((await usecase(Params(vehicleID: vehicle.id))).fold(
      (failure) => VehicleDetailRefuelingsError(),
      (payload) => VehicleDetailRefuelingsLoaded(payload),
    ));
  }
}
