import 'package:equatable/equatable.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();
}

class FetchVehicles extends VehicleEvent {
  const FetchVehicles();

  @override
  List<Object> get props => [];
}
