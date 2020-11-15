import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'vat_rate.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
// ignore: must_be_immutable
class VatRate extends Equatable {
  VatRate();

  @JsonKey(name: 'Id')
  String id;

  @JsonKey(name: 'VAT')
  String vat;

  factory VatRate.fromJson(Map<String, dynamic> json) => _$VatRateFromJson(json);

  Map<String, dynamic> toJson() => _$VatRateToJson(this);

  @override
  List<Object> get props => [id, vat];
}
