import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'e_token.g.dart';

@JsonSerializable()
class EToken extends Equatable {
  EToken({@required this.accessToken});

  @JsonKey(name: 'AccessToken')
  String accessToken;

  factory EToken.fromJson(Map<String, dynamic> json) => _$ETokenFromJson(json);

  Map<String, dynamic> toJson() => _$ETokenToJson(this);

  @override
  List<Object> get props => [accessToken];
}
