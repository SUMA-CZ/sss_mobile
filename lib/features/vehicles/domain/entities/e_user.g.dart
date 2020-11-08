// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EUser _$EUserFromJson(Map json) {
  return EUser()
    ..id = json['Id'] as String
    ..vin = json['Email'] as String
    ..name = json['Name'] as String;
}

Map<String, dynamic> _$EUserToJson(EUser instance) => <String, dynamic>{
      'Id': instance.id,
      'Email': instance.vin,
      'Name': instance.name,
    };
