import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_trips_for_vehicle.dart';

part 'vehicle_detail_trips_state.dart';

class VehicleDetailTripsCubit extends Cubit<VehicleDetailTripsState> {
  VehicleDetailTripsCubit({@required this.usecase, @required this.vehicle})
      : assert(usecase != null, vehicle != null),
        super(VehicleDetailTripsInitial());

  final GetTripsForVehicle usecase;
  final Vehicle vehicle;

  void getTrips() async {
    emit(VehicleDetailTripsLoading());
    emit((await usecase(Params(vehicleID: vehicle.id))).fold(
      (failure) => VehicleDetailTripsError(),
      (payload) => VehicleDetailTripsLoaded(payload),
    ));
  }
}
