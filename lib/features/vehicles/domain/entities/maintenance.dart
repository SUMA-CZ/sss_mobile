import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'maintenance.g.dart';

@JsonSerializable()
class Maintenance extends Equatable {
  Maintenance();

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'Date')
  DateTime date;

  @JsonKey(name: 'State')
  String state;

  @JsonKey(name: 'Price')
  double price;

  @JsonKey(name: 'Description')
  String description;

  @JsonKey(name: 'Note')
  String note;

  @JsonKey(name: 'MaintenanceLocationId')
  int maintenanceLocationId;

  @JsonKey(name: 'VATRateId')
  int vatRateId;

  @JsonKey(name: 'User')
  User user;

  @JsonKey(name: 'ScanURL')
  String scanURL;

  factory Maintenance.fromJson(Map<String, dynamic> json) => _$EMaintenanceFromJson(json);

  Map<String, dynamic> toJson() => _$EMaintenanceToJson(this);

  @override
  List<Object> get props =>
      [id, date, state, price, description, note, maintenanceLocationId, vatRateId, user, scanURL];
}
