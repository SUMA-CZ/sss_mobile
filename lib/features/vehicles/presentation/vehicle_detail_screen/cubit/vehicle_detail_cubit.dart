import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
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
}
