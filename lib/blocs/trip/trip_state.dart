import 'package:equatable/equatable.dart';
import 'package:sss_mobile/models/trip.dart';

abstract class TripState extends Equatable {
  const TripState();

  @override
  List<Object> get props => [];
}

class TripError extends TripState {
  final String message;

  TripError(this.message);
}

class TripUndefined extends TripState {}

class TripEditing extends TripWithData {
  final Trip trip;

  const TripEditing(this.trip) : super(trip);

  @override
  List<Object> get props => [trip];
}

class TripSaving extends TripWithData {
  final Trip trip;

  const TripSaving(this.trip) : super(trip);

  @override
  List<Object> get props => [trip];
}

class TripWithData extends TripState {
  final Trip trip;

  const TripWithData(this.trip);

  @override
  List<Object> get props => [trip];
}








class TripSuccess extends TripState {}
