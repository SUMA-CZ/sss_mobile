part of 'get_vehicles_bloc.dart';

abstract class GetVehiclesState extends Equatable {
  const GetVehiclesState();
}

class GetVehiclesInitial extends GetVehiclesState {
  @override
  List<Object> get props => [];
}

class GetVehiclesStateEmpty extends GetVehiclesState {
  @override
  List<Object> get props => [];
}

class GetVehiclesStateLoading extends GetVehiclesState {
  @override
  List<Object> get props => [];
}

class GetVehiclesStateError extends GetVehiclesState {
  final String message;

  GetVehiclesStateError({this.message});

  @override
  List<Object> get props => [message];
}

class GetVehiclesStateLoaded extends GetVehiclesState {
  final List<Vehicle> vehicles;

  GetVehiclesStateLoaded({@required this.vehicles});

  List<Object> get props => [vehicles];
}
