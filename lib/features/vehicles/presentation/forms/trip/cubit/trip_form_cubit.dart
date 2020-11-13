import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_trip.dart';

part 'trip_form_state.dart';

class TripFormCubit extends Cubit<TripFormState> {
  TripFormCubit({@required this.usecase, @required this.vehicle})
      : assert(usecase != null, vehicle != null),
        super(TripFormInitial());

  final CreateTrip usecase;
  final Vehicle vehicle;

  void createTrip(Trip trip) async {
    emit(TripFormLoading());
    emit((await usecase(Params(vehicleID: vehicle.id, trip: trip))).fold(
      (failure) => TripFormError(),
      (payload) => TripFormCreated(),
    ));
  }

  void deleteTrip() async {
    // TODO:
  }
}
