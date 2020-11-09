part of 'vehicle_detail_cubit.dart';

abstract class VehicleDetailState extends Equatable {
  const VehicleDetailState();
}

class VehicleDetailInitial extends VehicleDetailState {
  final Vehicle vehicle;

  VehicleDetailInitial({@required this.vehicle});
  @override
  List<Object> get props => [vehicle];
}

class VDSTripsLoaded extends VehicleDetailState {
  final List<Trip> trips;

  VDSTripsLoaded(this.trips);

  @override
  List<Object> get props => [trips];
}

class VDSTripsLoading extends VehicleDetailState {
  @override
  List<Object> get props => [];
}

class VDSTripsError extends VehicleDetailState {
  @override
  List<Object> get props => [];
}

class VDSRefuelingLoaded extends VehicleDetailState {
  final List<Refueling> refuelings;

  VDSRefuelingLoaded(this.refuelings);

  @override
  List<Object> get props => [refuelings];
}

class VDSRefuelingsLoading extends VehicleDetailState {
  @override
  List<Object> get props => [];
}

class VDSRefuelingsError extends VehicleDetailState {
  @override
  List<Object> get props => [];
}

class VDSMaintenancesLoaded extends VehicleDetailState {
  final List<Maintenance> maintenances;

  VDSMaintenancesLoaded(this.maintenances);

  @override
  List<Object> get props => [maintenances];
}

class VDSMaintenancesLoading extends VehicleDetailState {
  @override
  List<Object> get props => [];
}

class VDSMaintenancesError extends VehicleDetailState {
  @override
  List<Object> get props => [];
}
