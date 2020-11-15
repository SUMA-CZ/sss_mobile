part of 'trips_cubit.dart';

abstract class TripsState extends Equatable {
  const TripsState();
}

class TripsStateInitial extends TripsState {
  @override
  List<Object> get props => [];
}

class TripsStateLoaded extends TripsState {
  final List<Trip> trips;

  TripsStateLoaded(this.trips);

  @override
  List<Object> get props => [trips];
}

class TripsStateLoading extends TripsState {
  @override
  List<Object> get props => [];
}

class TripsStateError extends TripsState {
  @override
  List<Object> get props => [];
}

class TripsStateErrorDeleting extends TripsState {
  @override
  List<Object> get props => [];
}

class TripsStateDeleted extends TripsState {
  @override
  List<Object> get props => [];
}
