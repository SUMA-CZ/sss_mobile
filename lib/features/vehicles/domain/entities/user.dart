import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
// ignore: must_be_immutable
class User extends Equatable {
  User();

  @JsonKey(name: 'Id')
  String id;

  @JsonKey(name: 'Email')
  String vin;

  @JsonKey(name: 'Name')
  String name;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [id, vin, name];
}
