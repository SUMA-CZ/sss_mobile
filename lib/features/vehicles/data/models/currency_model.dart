import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/currency.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'currency_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
// ignore: must_be_immutable
class CurrencyModel extends Currency {
  CurrencyModel();

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => _$CurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);
}
