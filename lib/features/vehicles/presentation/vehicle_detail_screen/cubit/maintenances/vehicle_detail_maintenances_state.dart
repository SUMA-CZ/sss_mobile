part of 'vehicle_detail_maintenances_cubit.dart';

abstract class VehicleDetailMaintenancesState extends Equatable {
  const VehicleDetailMaintenancesState();
}

class VehicleDetailMaintenancesInitial extends VehicleDetailMaintenancesState {
  @override
  List<Object> get props => [];
}

class VehicleDetailMaintenancesLoaded extends VehicleDetailMaintenancesState {
  final List<Maintenance> maintenances;

  VehicleDetailMaintenancesLoaded(this.maintenances);

  @override
  List<Object> get props => [maintenances];
}

class VehicleDetailMaintenancesLoading extends VehicleDetailMaintenancesState {
  @override
  List<Object> get props => [];
}

class VehicleDetailMaintenancesError extends VehicleDetailMaintenancesState {
  @override
  List<Object> get props => [];
}

class VehicleDetailMaintenancesErrorDeleting extends VehicleDetailMaintenancesState {
  @override
  List<Object> get props => [];
}
