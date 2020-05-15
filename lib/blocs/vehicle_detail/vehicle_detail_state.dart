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

class VehicleDetailTripsEmpty extends VehicleDetailState {}

class VehicleDetailTripsLoaded extends VehicleDetailState {
  final List<Trip> trips;

  const VehicleDetailTripsLoaded({@required this.trips}) : assert(trips != null);

  @override
  List<Object> get props => [trips];
}

class VehicleDetailMaintenanceEmpty extends VehicleDetailState {}

class VehicleDetailMaintenanceLoaded extends VehicleDetailState {
  final List<Maintenance> maintenances;

  const VehicleDetailMaintenanceLoaded({@required this.maintenances}) : assert(maintenances != null);

  @override
  List<Object> get props => [maintenances];
}

class VehicleDetailRefuelingsEmpty extends VehicleDetailState {}

class VehicleDetailRefuelingsLoaded extends VehicleDetailState {
  final List<Refueling> refuelings;

  const VehicleDetailRefuelingsLoaded({@required this.refuelings}) : assert(refuelings != null);

  @override
  List<Object> get props => [refuelings];
}