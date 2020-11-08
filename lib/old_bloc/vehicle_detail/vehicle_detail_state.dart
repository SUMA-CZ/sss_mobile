// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import 'package:sss_mobile/models/vehicle.dart';
//
// abstract class VehicleDetailState extends Equatable {
//   const VehicleDetailState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class VehicleDetailLoading extends VehicleDetailState {}
//
// class VehicleDetailStateWithVehicle extends VehicleDetailState {
//
//   final Vehicle vehicle;
//
//   const VehicleDetailStateWithVehicle(this.vehicle) : assert(vehicle != null);
//
//   @override
//   List<Object> get props => [vehicle];
// }
//
// class VehicleDetailLoaded extends VehicleDetailStateWithVehicle {
//
//   final Vehicle vehicle;
//
//   const VehicleDetailLoaded({@required this.vehicle}) : super(vehicle);
//
//   @override
//   List<Object> get props => [vehicle];
// }
//
//
// class VehicleDetailFullyLoading extends VehicleDetailState {}
//
// class VehicleDetailFullyLoaded extends VehicleDetailStateWithVehicle {
//   final Vehicle vehicle;
//
//   const VehicleDetailFullyLoaded({@required this.vehicle}) : super(vehicle);
//
//   @override
//   List<Object> get props => [vehicle];
// }
//
// class VehicleDetailError extends VehicleDetailState {
//   final String message;
//
//   const VehicleDetailError({@required this.message}) : assert(message != null);
// }
