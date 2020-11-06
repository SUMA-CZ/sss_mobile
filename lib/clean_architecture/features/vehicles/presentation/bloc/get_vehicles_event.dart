part of 'get_vehicles_bloc.dart';

abstract class GetVehiclesEvent extends Equatable {
  const GetVehiclesEvent();
}

class GetVehiclesEventGetVehicles extends GetVehiclesEvent {
  @override
  List<Object> get props => [];
}
