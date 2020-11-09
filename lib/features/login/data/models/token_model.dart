import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/login/domain/entities/token.dart';

part 'token_model.g.dart';

@JsonSerializable()
class TokenModel extends Token {
  factory TokenModel.fromJson(Map<String, dynamic> json) => _$ETokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$ETokenModelToJson(this);

  TokenModel({@required String token}) : super(accessToken: token);
}
