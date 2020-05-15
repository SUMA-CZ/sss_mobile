import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/models/vehicle.dart';

abstract class VehicleListState extends Equatable {
  const VehicleListState();

  @override
  List<Object> get props => [];
}

class VehicleListEmpty extends VehicleListState {}

class VehicleListLoading extends VehicleListState {}

class VehicleListLoaded extends VehicleListState {
  final List<Vehicle> vehicles;

  const VehicleListLoaded({@required this.vehicles}) : assert(vehicles != null);

  @override
  List<Object> get props => [vehicles];
}

class VehicleListError extends VehicleListState {}
