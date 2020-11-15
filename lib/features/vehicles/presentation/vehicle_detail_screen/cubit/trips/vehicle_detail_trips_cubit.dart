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
      {@required this.getTripsForVehicle, @required this.deleteTripUsecase, @required this.vehicle})
      : assert(getTripsForVehicle != null, vehicle != null),
        super(VehicleDetailTripsInitial());

  final GetTripsForVehicle getTripsForVehicle;
  final DeleteTrip deleteTripUsecase;
  final Vehicle vehicle;

  void getTrips() async {
    emit(VehicleDetailTripsLoading());
    emit((await getTripsForVehicle(Params(vehicleID: vehicle.id))).fold(
      (failure) => VehicleDetailTripsError(),
      (payload) => VehicleDetailTripsLoaded(payload),
    ));
  }

  void deleteTrip(int tripID) async {
    emit(VehicleDetailTripsLoading());

    emit((await deleteTripUsecase(ParamsForDeleteTrip(vehicleID: vehicle.id, objectID: tripID))).fold(
      (failure) => VehicleDetailTripsErrorDeleting(),
      (payload) => null,
    ));

    emit((await getTripsForVehicle(Params(vehicleID: vehicle.id))).fold(
      (failure) => VehicleDetailTripsError(),
      (payload) => VehicleDetailTripsLoaded(payload),
    ));
  }
}
