import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_trip.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_trips_for_vehicle.dart';

part 'vehicle_detail_trips_state.dart';

class VehicleDetailTripsCubit extends Cubit<VehicleDetailTripsState> {
  VehicleDetailTripsCubit(
      {@required this.getTripsForVehicle, @required this.deleteTrip, @required this.vehicle})
      : assert(getTripsForVehicle != null, vehicle != null),
        super(VehicleDetailTripsInitial());

  final GetTripsForVehicle getTripsForVehicle;
  final DeleteTrip deleteTrip;
  final Vehicle vehicle;

  void getTrips() async {
    emit(VehicleDetailTripsLoading());
    emit((await getTripsForVehicle(Params(vehicleID: vehicle.id))).fold(
      (failure) => VehicleDetailTripsError(),
      (payload) => VehicleDetailTripsLoaded(payload),
    ));
  }

  void delete(int tripID) async {
    emit(VehicleDetailTripsLoading());

    emit((await deleteTrip(ParamsForDeleteTrip(vehicleID: vehicle.id, objectID: tripID))).fold(
      (failure) => VehicleDetailTripsErrorDeleting(),
      (payload) => VehicleDetailTripsDeleted(),
    ));

    getTrips();
  }
}
