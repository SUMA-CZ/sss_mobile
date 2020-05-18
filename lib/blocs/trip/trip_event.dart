import 'package:equatable/equatable.dart';
import 'package:sss_mobile/models/trip.dart';
import 'package:sss_mobile/models/vehicle.dart';

abstract class TripEvent extends Equatable {
  const TripEvent();
}

class ShowTrip extends TripEvent {
  final Trip trip;
  final Vehicle vehicle;

  ShowTrip(this.trip, this.vehicle);

  @override
  List<Object> get props => [trip];
}

class SaveTrip extends TripEvent {
  final Trip trip;
  final Vehicle vehicle;

  SaveTrip(this.trip, this.vehicle);

  @override
  List<Object> get props => [trip];
}
