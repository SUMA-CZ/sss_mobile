import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_trip.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_trips_for_vehicle.dart';

part 'trips_state.dart';

class TripsCubit extends Cubit<TripsState> {
  TripsCubit({@required this.getTripsForVehicle, @required this.deleteTrip, @required this.vehicle})
      : assert(getTripsForVehicle != null, vehicle != null),
        super(TripsStateInitial());

  final ReadTripsForVehicle getTripsForVehicle;
  final DeleteTrip deleteTrip;
  final Vehicle vehicle;

  void getTrips() async {
    emit(TripsStateLoading());
    emit((await getTripsForVehicle(Params(vehicleID: vehicle.id))).fold(
      (failure) => TripsStateError(),
      (payload) => TripsStateLoaded(payload),
    ));
  }

  void delete(int tripID) async {
    emit(TripsStateLoading());

    emit((await deleteTrip(ParamsForDeleteTrip(vehicleID: vehicle.id, objectID: tripID))).fold(
      (failure) => TripsStateErrorDeleting(),
      (payload) => TripsStateDeleted(),
    ));

    getTrips();
  }
}
