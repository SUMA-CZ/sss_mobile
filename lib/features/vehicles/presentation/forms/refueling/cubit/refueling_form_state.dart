part of 'refueling_form_cubit.dart';

abstract class RefuelingFormState extends Equatable {
  const RefuelingFormState();
  @override
  List<Object> get props => [];
}

class RefuelingFormInitial extends RefuelingFormState {}

class RefuelingFormLoading extends RefuelingFormState {}

class RefuelingFormCreated extends RefuelingFormState {}

class RefuelingFormError extends RefuelingFormState {}

class RefuelingFormLoaded extends RefuelingFormState {
  final Refueling refueling;

  RefuelingFormLoaded(this.refueling);
}
