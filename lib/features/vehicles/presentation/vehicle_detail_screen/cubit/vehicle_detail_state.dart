part of 'vehicle_detail_cubit.dart';

class VehicleDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class VehicleDetailInitial extends VehicleDetailState {
  final Vehicle vehicle;

  VehicleDetailInitial({@required this.vehicle});
  @override
  List<Object> get props => [vehicle];
}

class VehicleDetailLoading extends VehicleDetailState {}
