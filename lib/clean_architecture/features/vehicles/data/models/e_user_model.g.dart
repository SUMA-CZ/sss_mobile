// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EUserModel _$EUserModelFromJson(Map json) {
  return EUserModel()
    ..id = json['Id'] as String
    ..vin = json['Email'] as String
    ..name = json['Name'] as String;
}

Map<String, dynamic> _$EUserModelToJson(EUserModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Email': instance.vin,
      'Name': instance.name,
    };
