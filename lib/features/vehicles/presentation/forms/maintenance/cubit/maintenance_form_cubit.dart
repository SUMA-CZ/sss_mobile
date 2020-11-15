import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_maintenace.dart';

part 'maintenance_form_state.dart';

class MaintenanceFormCubit extends Cubit<MaintenanceFormState> {
  MaintenanceFormCubit({@required this.usecase, @required this.vehicle})
      : assert(usecase != null, vehicle != null),
        super(MaintenanceFormInitial());

  final CreateMaintenance usecase;
  final Vehicle vehicle;

  void createMaintenance(Maintenance refueling) async {
    emit(MaintenanceFormInitial());
    emit((await usecase(Params(vehicleID: vehicle.id, maintenance: refueling))).fold(
      (failure) => MaintenanceFormStateError(),
      (payload) => MaintenanceFormStateCreated(),
    ));
  }
}
