import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'e_token.g.dart';

@JsonSerializable()
class EToken extends Equatable{
  EToken();

  @JsonKey(name: 'AccessToken')
  String accessToken;

  factory EToken.fromJson(Map<String, dynamic> json) => _$ETokenFromJson(json);

  Map<String, dynamic> toJson() => _$ETokenToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => [accessToken];
}
