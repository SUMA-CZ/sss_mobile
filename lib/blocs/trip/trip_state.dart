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

class TripInitial extends TripState {
  final Trip trip;

  const TripInitial(this.trip);

  @override
  List<Object> get props => [trip];
}

class TripSaving extends TripState {}

class TripSuccess extends TripState {}
