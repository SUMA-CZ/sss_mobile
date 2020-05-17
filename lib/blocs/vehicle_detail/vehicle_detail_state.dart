import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/models/maintenance.dart';
import 'package:sss_mobile/models/refueling.dart';
import 'package:sss_mobile/models/trip.dart';
import 'package:sss_mobile/models/vehicle.dart';

abstract class VehicleDetailState extends Equatable {
  const VehicleDetailState();

  @override
  List<Object> get props => [];
}

class VehicleDetailLoading extends VehicleDetailState {}

class VehicleDetailLoaded extends VehicleDetailState {
  final Vehicle vehicle;

  const VehicleDetailLoaded({@required this.vehicle}) : assert(vehicle != null);

  @override
  List<Object> get props => [vehicle];
}

class VehicleDetailError extends VehicleDetailState {}