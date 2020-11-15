import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_refuelings_for_vehicle.dart';

part 'vehicle_detail_refuelings_state.dart';

class VehicleDetailRefuelingsCubit extends Cubit<VehicleDetailRefuelingsState> {
  VehicleDetailRefuelingsCubit(
      {@required this.getRefuelingsForVehicle,
      @required this.deleteRefueling,
      @required this.vehicle})
      : assert(getRefuelingsForVehicle != null && vehicle != null && deleteRefueling != null),
        super(VehicleDetailRefuelingsInitial());

  final GetRefuelingsForVehicle getRefuelingsForVehicle;
  final DeleteRefueling deleteRefueling;
  final Vehicle vehicle;

  void getRefuelings() async {
    emit(VehicleDetailRefuelingsLoading());
    emit((await getRefuelingsForVehicle(Params(vehicleID: vehicle.id))).fold(
      (failure) => VehicleDetailRefuelingsError(),
      (payload) => VehicleDetailRefuelingsLoaded(payload),
    ));
  }

  void delete(int refuelingID) async {
    emit(VehicleDetailRefuelingsLoading());

    emit((await deleteRefueling(
            ParamsForDeletingRefueling(vehicleID: vehicle.id, objectID: refuelingID)))
        .fold(
      (failure) => VehicleDetailRefuelingsErrorDeleting(),
      (payload) => null,
    ));

    await getRefuelings();
  }
}
