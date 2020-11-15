import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'fuel_type.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
// ignore: must_be_immutable
class FuelType extends Equatable {
  FuelType();

  @JsonKey(name: 'Id')
  String id;

  @JsonKey(name: 'Name')
  String name;

  factory FuelType.fromJson(Map<String, dynamic> json) => _$FuelTypeFromJson(json);

  Map<String, dynamic> toJson() => _$FuelTypeToJson(this);

  @override
  List<Object> get props => [id, name];
}
