import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/clean_architecture/features/login/domain/entities/e_token.dart';

part 'e_token_model.g.dart';

@JsonSerializable()
class ETokenModel extends EToken {
  factory ETokenModel.fromJson(Map<String, dynamic> json) => _$ETokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$ETokenModelToJson(this);

  ETokenModel();
}
