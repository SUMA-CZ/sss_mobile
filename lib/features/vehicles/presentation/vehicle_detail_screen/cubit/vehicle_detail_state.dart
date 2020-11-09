part of 'vehicle_detail_cubit.dart';

abstract class VehicleDetailState extends Equatable {
  const VehicleDetailState();
}

class VehicleDetailInitial extends VehicleDetailState {
  final Vehicle vehicle;

  VehicleDetailInitial({@required this.vehicle});
  @override
  List<Object> get props => [vehicle];
}
