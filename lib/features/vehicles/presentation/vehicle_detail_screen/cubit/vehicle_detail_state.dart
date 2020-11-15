part of 'vehicle_detail_cubit.dart';

class VehicleDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class VehicleDetailStateInitial extends VehicleDetailState {
  final Vehicle vehicle;

  VehicleDetailStateInitial({@required this.vehicle});
  @override
  List<Object> get props => [vehicle];
}

class VehicleDetailStateLoading extends VehicleDetailState {}
