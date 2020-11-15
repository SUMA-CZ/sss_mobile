import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_refuelings_for_vehicle.dart';

part 'refuelings_state.dart';

class RefuelingsCubit extends Cubit<RefuelingsState> {
  RefuelingsCubit(
      {@required this.getRefuelingsForVehicle,
      @required this.deleteRefueling,
      @required this.vehicle})
      : assert(getRefuelingsForVehicle != null && vehicle != null && deleteRefueling != null),
        super(RefuelingsStateInitial());

  final ReadRefuelingsForVehicle getRefuelingsForVehicle;
  final DeleteRefueling deleteRefueling;
  final Vehicle vehicle;

  void read() async {
    emit(RefuelingsStateLoading());
    emit((await getRefuelingsForVehicle(Params(vehicleID: vehicle.id))).fold(
      (failure) => RefuelingsStateError(),
      (payload) => RefuelingsStateLoaded(payload),
    ));
  }

  void delete(int refuelingID) async {
    emit(RefuelingsStateLoading());

    emit((await deleteRefueling(
            ParamsForDeletingRefueling(vehicleID: vehicle.id, objectID: refuelingID)))
        .fold(
      (failure) => RefuelingsStateErrorDeleting(),
      (payload) => RefuelingsStateDeleted(),
    ));

    await read();
  }
}
