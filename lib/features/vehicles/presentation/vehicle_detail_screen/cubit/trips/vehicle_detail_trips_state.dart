part of 'vehicle_detail_trips_cubit.dart';

abstract class VehicleDetailTripsState extends Equatable {
  const VehicleDetailTripsState();
}

class VehicleDetailTripsInitial extends VehicleDetailTripsState {
  @override
  List<Object> get props => [];
}

class VehicleDetailTripsLoaded extends VehicleDetailTripsState {
  final List<Trip> trips;

  VehicleDetailTripsLoaded(this.trips);

  @override
  List<Object> get props => [trips];
}

class VehicleDetailTripsLoading extends VehicleDetailTripsState {
  @override
  List<Object> get props => [];
}

class VehicleDetailTripsError extends VehicleDetailTripsState {
  @override
  List<Object> get props => [];
}

class VehicleDetailTripsErrorDeleting extends VehicleDetailTripsState {
  @override
  List<Object> get props => [];
}

class VehicleDetailTripsDeleted extends VehicleDetailTripsState {
  @override
  List<Object> get props => [];
}
