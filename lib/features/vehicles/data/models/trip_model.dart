import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/user.dart';

part 'trip_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class TripModel extends Trip {
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory TripModel.fromJson(Map<String, dynamic> json) => _$TripModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  @override
  Map<String, dynamic> toJson() => _$TripModelToJson(this);

  TripModel();
}
