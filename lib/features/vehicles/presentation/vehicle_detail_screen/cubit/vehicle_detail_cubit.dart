import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

part 'vehicle_detail_state.dart';

class VehicleDetailCubit extends Cubit<VehicleDetailState> {
  VehicleDetailCubit({@required this.vehicleRepository, @required this.vehicle})
      : assert(vehicleRepository != null, vehicle != null),
        super(VehicleDetailInitial(vehicle: vehicle)) {
    emit(VehicleDetailInitial(vehicle: vehicle));
  }

  final VehicleRepository vehicleRepository;
  final Vehicle vehicle;

  void getVehicle() async {
    emit(VehicleDetailInitial(vehicle: vehicle));
  }

  void getTrips() async {
    emit(VDSTripsLoading());
    emit((await vehicleRepository.getTripsForVehicleID(vehicle.id)).fold(
      (failure) => VDSTripsError(),
      (payload) => VDSTripsLoaded(payload),
    ));
  }

  void getRefuelings() async {
    emit(VDSRefuelingsLoading());
    emit((await vehicleRepository.getRefuelingsForVehicleID(vehicle.id)).fold(
      (failure) => VDSRefuelingsError(),
      (payload) => VDSRefuelingLoaded(payload),
    ));
  }

  void getMaintenances() async {
    emit(VDSMaintenancesLoading());
    emit((await vehicleRepository.getMaintenancesForVehicleID(vehicle.id)).fold(
      (failure) => VDSMaintenancesError(),
      (payload) => VDSMaintenancesLoaded(payload),
    ));
  }
}
