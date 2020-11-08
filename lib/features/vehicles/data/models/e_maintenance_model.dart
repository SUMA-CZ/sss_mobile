import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/e_maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/e_user.dart';

part 'e_maintenance_model.g.dart';

@JsonSerializable()
class EMaintenanceModel extends EMaintenance {
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory EMaintenanceModel.fromJson(Map<String, dynamic> json) =>
      _$EMaintenanceModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$EMaintenanceModelToJson(this);

  EMaintenanceModel();
}
