part of 'vehicle_detail_cubit.dart';

abstract class VehicleDetailState extends Equatable {
  @override
  List<Object> get props => throw [hashCode];
}

class VehicleDetailInitial extends VehicleDetailState {
  final Vehicle vehicle;

  VehicleDetailInitial({@required this.vehicle});
  @override
  List<Object> get props => [vehicle];
}

class VehicleDetailLoading extends VehicleDetailState {}
