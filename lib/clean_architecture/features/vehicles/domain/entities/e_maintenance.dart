import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/models/user.dart';

import 'e_user.dart';

part 'e_maintenance.g.dart';

@JsonSerializable()
class EMaintenance {
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

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory EMaintenance.fromJson(Map<String, dynamic> json) => _$EMaintenanceFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$EMaintenanceToJson(this);
}
