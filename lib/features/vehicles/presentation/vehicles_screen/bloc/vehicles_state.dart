part of 'vehicles_bloc.dart';

abstract class VehiclesState extends Equatable {
  const VehiclesState();
}

class VehiclesStateInitial extends VehiclesState {
  @override
  List<Object> get props => [];
}

class VehiclesStateEmpty extends VehiclesState {
  @override
  List<Object> get props => [];
}

class VehiclesStateLoading extends VehiclesState {
  @override
  List<Object> get props => [];
}

class VehiclesStateError extends VehiclesState {
  final String message;

  VehiclesStateError({this.message});

  @override
  List<Object> get props => [message];
}

class VehiclesStateLoaded extends VehiclesState {
  final List<Vehicle> vehicles;

  VehiclesStateLoaded({@required this.vehicles});

  @override
  List<Object> get props => [vehicles];
}
