import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_maintenances_for_vehicle.dart';

part 'vehicle_detail_maintenances_state.dart';

class VehicleDetailMaintenancesCubit extends Cubit<VehicleDetailMaintenancesState> {
  VehicleDetailMaintenancesCubit({@required this.usecase, @required this.vehicle})
      : assert(usecase != null, vehicle != null),
        super(VehicleDetailMaintenancesInitial());

  final GetMaintenancesForVehicle usecase;
  final Vehicle vehicle;

  void getMaintenances() async {
    emit(VehicleDetailMaintenancesLoading());
    emit((await usecase(Params(vehicleID: vehicle.id))).fold(
      (failure) => VehicleDetailMaintenancesError(),
      (payload) => VehicleDetailMaintenancesLoaded(payload),
    ));
  }
}
