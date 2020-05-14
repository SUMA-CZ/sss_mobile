import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/models/vehicle.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object> get props => [];
}

class VehicleEmpty extends VehicleState {}

class VehicleLoading extends VehicleState {}

class VehicleLoaded extends VehicleState {
  final List<Vehicle> vehicles;

  const VehicleLoaded({@required this.vehicles}) : assert(vehicles != null);

  @override
  List<Object> get props => [vehicles];
}

class VehicleError extends VehicleState {}
