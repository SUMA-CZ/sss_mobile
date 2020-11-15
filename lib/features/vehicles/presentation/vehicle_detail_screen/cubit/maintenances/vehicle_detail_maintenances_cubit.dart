import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_maintenances_for_vehicle.dart';

part 'vehicle_detail_maintenances_state.dart';

class VehicleDetailMaintenancesCubit extends Cubit<VehicleDetailMaintenancesState> {
  VehicleDetailMaintenancesCubit(
      {@required this.getMaintenancesForTrip,
      @required this.deleteMaintenance,
      @required this.vehicle})
      : assert(getMaintenancesForTrip != null && vehicle != null && deleteMaintenance != null),
        super(VehicleDetailMaintenancesInitial());

  final GetMaintenancesForVehicle getMaintenancesForTrip;
  final DeleteMaintenance deleteMaintenance;
  final Vehicle vehicle;

  void getMaintenances() async {
    emit(VehicleDetailMaintenancesLoading());
    emit((await getMaintenancesForTrip(Params(vehicleID: vehicle.id))).fold(
      (failure) => VehicleDetailMaintenancesError(),
      (payload) => VehicleDetailMaintenancesLoaded(payload),
    ));
  }

  void delete(int maintenanceID) async {
    emit(VehicleDetailMaintenancesLoading());

    emit((await deleteMaintenance(
            ParamsForDeletingMaintenance(vehicleID: vehicle.id, objectID: maintenanceID)))
        .fold(
      (failure) => VehicleDetailMaintenancesErrorDeleting(),
      (payload) => null,
    ));

    await getMaintenances();
  }
}
