part of '../refuelings/refuelings_cubit.dart';

abstract class RefuelingsState extends Equatable {
  const RefuelingsState();
}

class RefuelingsStateInitial extends RefuelingsState {
  @override
  List<Object> get props => [];
}

class RefuelingsStateLoaded extends RefuelingsState {
  final List<Refueling> refuelings;

  RefuelingsStateLoaded(this.refuelings);

  @override
  List<Object> get props => [refuelings];
}

class RefuelingsStateLoading extends RefuelingsState {
  @override
  List<Object> get props => [];
}

class RefuelingsStateError extends RefuelingsState {
  @override
  List<Object> get props => [];
}

class RefuelingsStateErrorDeleting extends RefuelingsState {
  @override
  List<Object> get props => [];
}

class RefuelingsStateDeleted extends RefuelingsState {
  @override
  List<Object> get props => [];
}
