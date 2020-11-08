import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'e_user.dart';

part 'e_maintenance.g.dart';

@JsonSerializable()
class EMaintenance extends Equatable {
  EMaintenance();

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
  EUser user;

  @JsonKey(name: 'ScanURL')
  String scanURL;

  factory EMaintenance.fromJson(Map<String, dynamic> json) => _$EMaintenanceFromJson(json);

  Map<String, dynamic> toJson() => _$EMaintenanceToJson(this);

  @override
  List<Object> get props =>
      [id, date, state, price, description, note, maintenanceLocationId, vatRateId, user, scanURL];
}
