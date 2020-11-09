// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$EUserModelFromJson(Map json) {
  return UserModel()
    ..id = json['Id'] as String
    ..vin = json['Email'] as String
    ..name = json['Name'] as String;
}

Map<String, dynamic> _$EUserModelToJson(UserModel instance) => <String, dynamic>{
      'Id': instance.id,
      'Email': instance.vin,
      'Name': instance.name,
    };
