import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_trip.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/trips/trips_cubit.dart';

part 'trip_form_state.dart';

class TripFormCubit extends Cubit<TripFormState> {
  TripFormCubit({@required this.usecase, @required this.vehicle, @required this.tripListCubit})
      : assert(usecase != null && vehicle != null && tripListCubit != null),
        super(TripFormInitial());

  final CreateTrip usecase;
  final Vehicle vehicle;
  final TripsCubit tripListCubit;

  void createTrip(Trip trip) async {
    emit(TripFormLoading());
    emit((await usecase(Params(vehicleID: vehicle.id, trip: trip))).fold(
      (failure) => TripFormError(),
      (payload) => TripFormCreated(),
    ));
    emit(TripFormLoaded(trip));
    tripListCubit.getTrips();
  }

  void setLastTrip(Trip trip) async {
    emit(TripFormLoading());
    emit(TripFormLoaded(trip));
  }

  void deleteTrip() async {
    // TODO:
  }
}
