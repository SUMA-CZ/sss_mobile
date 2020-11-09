part of '../refuelings/vehicle_detail_refuelings_cubit.dart';

abstract class VehicleDetailRefuelingsState extends Equatable {
  const VehicleDetailRefuelingsState();
}

class VehicleDetailRefuelingsInitial extends VehicleDetailRefuelingsState {
  @override
  List<Object> get props => [];
}

class VehicleDetailRefuelingsLoaded extends VehicleDetailRefuelingsState {
  final List<Refueling> refuelings;

  VehicleDetailRefuelingsLoaded(this.refuelings);

  @override
  List<Object> get props => [refuelings];
}

class VehicleDetailRefuelingsLoading extends VehicleDetailRefuelingsState {
  @override
  List<Object> get props => [];
}

class VehicleDetailRefuelingsError extends VehicleDetailRefuelingsState {
  @override
  List<Object> get props => [];
}
