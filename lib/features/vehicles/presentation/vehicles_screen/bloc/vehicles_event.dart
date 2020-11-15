part of 'vehicles_bloc.dart';

abstract class VehiclesEvent extends Equatable {
  const VehiclesEvent();
}

class VehiclesEventRead extends VehiclesEvent {
  @override
  List<Object> get props => [];
}
