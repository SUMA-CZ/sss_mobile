import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'e_user.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class EUser extends Equatable {
  EUser();

  @JsonKey(name: 'Id')
  String id;

  @JsonKey(name: 'Email')
  String vin;

  @JsonKey(name: 'Name')
  String name;

  factory EUser.fromJson(Map<String, dynamic> json) => _$EUserFromJson(json);

  Map<String, dynamic> toJson() => _$EUserToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => [id, vin, name];
}
