part of 'refueling_form_cubit.dart';

abstract class RefuelingFormState extends Equatable {
  const RefuelingFormState();
  @override
  List<Object> get props => [];
}

class RefuelingFormStateInitial extends RefuelingFormState {}

class RefuelingFormStateLoading extends RefuelingFormState {}

class RefuelingFormStateCreated extends RefuelingFormState {}

class RefuelingFormStateError extends RefuelingFormState {}

class RefuelingFormStateLoaded extends RefuelingFormState {
  final Refueling refueling;
  final List<VatRate> vatRates;
  final List<FuelType> fuelTypes;

  RefuelingFormStateLoaded({this.refueling, this.fuelTypes, this.vatRates});
}
