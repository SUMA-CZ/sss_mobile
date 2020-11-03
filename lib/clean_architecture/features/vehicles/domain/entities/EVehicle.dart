import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class EVehicle extends Equatable {
  final int id;
  final String spz;
  final String vin;
  final String name;
  final String note;
  final int odometer;
  final double latitude;
  final double longitude;
  final int fuelLevel;

  EVehicle(
      {@required this.id,
      @required this.spz,
      this.vin,
      this.name,
      this.note,
      this.odometer,
      this.latitude,
      this.longitude,
      this.fuelLevel});

  @override
  List<Object> get props => [id];
}
