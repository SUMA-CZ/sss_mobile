part of 'trip_form_cubit.dart';

@immutable
abstract class TripFormState extends Equatable {
  @override
  List<Object> get props => [];
}

class TripFormInitial extends TripFormState {}

class TripFormLoading extends TripFormState {}

class TripFormCreated extends TripFormState {}

class TripFormError extends TripFormState {}

class TripFormLoaded extends TripFormState {
  final Trip trip;

  TripFormLoaded(this.trip);
}
