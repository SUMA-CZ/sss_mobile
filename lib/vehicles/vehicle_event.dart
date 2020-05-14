import 'package:equatable/equatable.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();
}

class FetchVehicles extends VehicleEvent {
  const FetchVehicles();

  @override
  List<Object> get props => [];
}

class TESTEvent extends VehicleEvent {
  const TESTEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}
