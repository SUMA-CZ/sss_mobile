import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sss_mobile/models/vehicle.dart';

abstract class VehicleDetailEvent extends Equatable {
  const VehicleDetailEvent();
}

class ShowVehicle extends VehicleDetailEvent {
  final Vehicle vehicle;

  const ShowVehicle({@required this.vehicle});

  @override
  List<Object> get props => [vehicle];

}