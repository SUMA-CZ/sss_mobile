part of 'maintenances_cubit.dart';

abstract class MaintenancesState extends Equatable {
  const MaintenancesState();
}

class MaintenancesStateInitial extends MaintenancesState {
  @override
  List<Object> get props => [];
}

class MaintenancesStateLoaded extends MaintenancesState {
  final List<Maintenance> maintenances;

  MaintenancesStateLoaded(this.maintenances);

  @override
  List<Object> get props => [maintenances];
}

class MaintenancesStateLoading extends MaintenancesState {
  @override
  List<Object> get props => [];
}

class MaintenancesStateError extends MaintenancesState {
  @override
  List<Object> get props => [];
}

class MaintenancesStateErrorDeleting extends MaintenancesState {
  @override
  List<Object> get props => [];
}

class MaintenancesStateDeleted extends MaintenancesState {
  @override
  List<Object> get props => [];
}
