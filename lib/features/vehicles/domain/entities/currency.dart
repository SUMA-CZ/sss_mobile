import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'currency.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
// ignore: must_be_immutable
class Currency extends Equatable {
  Currency();

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'Code')
  String code;

  @JsonKey(name: 'Country')
  String country;

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);

  @override
  List<Object> get props => [id, code];
}
