import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/e_user.dart';

part 'e_user_model.g.dart';

@JsonSerializable()
class EUserModel extends EUser {
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory EUserModel.fromJson(Map<String, dynamic> json) => _$EUserModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$EUserModelToJson(this);

  EUserModel();
}
