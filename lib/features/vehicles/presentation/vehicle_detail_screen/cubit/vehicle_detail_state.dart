part of 'vehicle_detail_cubit.dart';

abstract class VehicleDetailState extends Equatable {
  const VehicleDetailState();
}

class VehicleDetailInitial extends VehicleDetailState {
  @override
  List<Object> get props => [];
}

class VDSLoading extends VehicleDetailState {
  @override
  List<Object> get props => [];
}

class VDSError extends VehicleDetailState {
  final String message;

  VDSError(this.message);
  @override
  List<Object> get props => [message];
}

class VDSShowTrips extends VehicleDetailState {
  final List<Trip> trips;

  VDSShowTrips(this.trips);

  @override
  List<Object> get props => [trips];
}

class VDSShowRefueling extends VehicleDetailState {
  final List<Refueling> refuelings;

  VDSShowRefueling(this.refuelings);

  @override
  List<Object> get props => [refuelings];
}

class VDSShowMaintenances extends VehicleDetailState {
  final List<Maintenance> maintenances;

  VDSShowMaintenances(this.maintenances);

  @override
  List<Object> get props => [maintenances];
}
