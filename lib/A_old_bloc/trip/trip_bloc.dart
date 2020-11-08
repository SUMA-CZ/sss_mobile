// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:sss_mobile/blocs/trip/trip_event.dart';
// import 'package:sss_mobile/blocs/trip/trip_state.dart';
// import 'package:sss_mobile/clean_architecture/features/vehicles/domain/repositories/vehicle_repository.dart';
//
// class TripBloc extends Bloc<TripEvent, TripState> {
//   final VehicleRepository vehicleRepository;
//
//   TripBloc({@required this.vehicleRepository})
//       : assert(vehicleRepository != null),
//         super(TripUndefined());
//
//   @override
//   Stream<TripState> mapEventToState(TripEvent event) async* {
//     if (event is ShowTrip) {
//       yield TripEditing(event.trip);
//     }
//
//     if (event is SaveTrip) {
//       yield TripSaving(event.trip);
//       try {
//         // final Trip trip = await vehicleRepository.saveTrip(event.trip, event.vehicle);
//         yield TripSuccess();
//       } catch (e) {
//         yield TripError(e.toString());
//       }
//     }
//   }
// }
