import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'token.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Token extends Equatable {
  Token({@required this.accessToken});

  @JsonKey(name: 'AccessToken')
  String accessToken;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  List<Object> get props => [accessToken];
}
