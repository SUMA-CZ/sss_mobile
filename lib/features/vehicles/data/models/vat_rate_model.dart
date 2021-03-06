import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vat_rate.dart';

part 'vat_rate_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class VatRateModel extends VatRate {
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory VatRateModel.fromJson(Map<String, dynamic> json) => _$VatRateModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  @override
  Map<String, dynamic> toJson() => _$VatRateModelToJson(this);

  VatRateModel();
}
