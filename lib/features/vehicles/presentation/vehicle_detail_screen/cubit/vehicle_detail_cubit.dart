import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:dartz/dartz.dart';
part 'vehicle_detail_state.dart';

class VehicleDetailCubit extends Cubit<VehicleDetailState> {
  VehicleDetailCubit({@required this.vehicleRepository, @required this.vehicle})
      : assert(vehicleRepository != null, vehicle != null),
        super(VehicleDetailInitial());

  final VehicleRepository vehicleRepository;
  final Vehicle vehicle;

  void getTrips() async {
    emit(VDSLoading());
    emit ((await vehicleRepository.getTripsForVehicleID(vehicle.id)).fold(
          (failure) => VDSError('Failed To Get Data'),
          (payload) => VDSShowTrips(payload),
    ));
  }

  void getRefuelings() async {
    emit(VDSLoading());
    emit ((await vehicleRepository.getRefuelingsForVehicleID(vehicle.id)).fold(
          (failure) => VDSError('Failed To Get Data'),
          (payload) => VDSShowRefueling(payload),
    ));
  }

  void getMaintenances() async {
    emit(VDSLoading());
    emit ((await vehicleRepository.getMaintenancesForVehicleID(vehicle.id)).fold(
          (failure) => VDSError('Failed To Get Data'),
          (payload) => VDSShowMaintenances(payload),
    ));
  }
}
