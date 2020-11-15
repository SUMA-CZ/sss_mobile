part of 'maintenance_form_cubit.dart';

abstract class MaintenanceFormState extends Equatable {
  @override
  List<Object> get props => [];
}

class MaintenanceFormInitial extends MaintenanceFormState {}

class MaintenanceFormStateLoading extends MaintenanceFormState {}

class MaintenanceFormStateCreated extends MaintenanceFormState {}

class MaintenanceFormStateError extends MaintenanceFormState {}

class MaintenanceFormStateLoaded extends MaintenanceFormState {
  final Maintenance maintenance;

  MaintenanceFormStateLoaded(this.maintenance);
}
