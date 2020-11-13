import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/user.dart';

part 'maintenance_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class MaintenanceModel extends Maintenance {
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory MaintenanceModel.fromJson(Map<String, dynamic> json) => _$EMaintenanceModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  @override
  Map<String, dynamic> toJson() => _$EMaintenanceModelToJson(this);

  MaintenanceModel();
}
