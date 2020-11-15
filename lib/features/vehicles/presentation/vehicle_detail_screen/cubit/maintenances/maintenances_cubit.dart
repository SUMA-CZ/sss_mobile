import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_maintenances_for_vehicle.dart';

part 'maintenances_state.dart';

class MaintenancesCubit extends Cubit<MaintenancesState> {
  MaintenancesCubit(
      {@required this.getMaintenancesForTrip,
      @required this.deleteMaintenance,
      @required this.vehicle})
      : assert(getMaintenancesForTrip != null && vehicle != null && deleteMaintenance != null),
        super(MaintenancesStateInitial());

  final ReadMaintenancesForVehicle getMaintenancesForTrip;
  final DeleteMaintenance deleteMaintenance;
  final Vehicle vehicle;

  void read() async {
    emit(MaintenancesStateLoading());
    emit((await getMaintenancesForTrip(Params(vehicleID: vehicle.id))).fold(
      (failure) => MaintenancesStateError(),
      (payload) => MaintenancesStateLoaded(payload),
    ));
  }

  void delete(int maintenanceID) async {
    emit(MaintenancesStateLoading());

    emit((await deleteMaintenance(
            ParamsForDeletingMaintenance(vehicleID: vehicle.id, objectID: maintenanceID)))
        .fold(
      (failure) => MaintenancesStateErrorDeleting(),
      (payload) => MaintenancesStateDeleted(),
    ));

    await read();
  }
}
