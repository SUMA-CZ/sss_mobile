// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$EUserFromJson(Map json) {
  return User()
    ..id = json['Id'] as String
    ..vin = json['Email'] as String
    ..name = json['Name'] as String;
}

Map<String, dynamic> _$EUserToJson(User instance) => <String, dynamic>{
      'Id': instance.id,
      'Email': instance.vin,
      'Name': instance.name,
    };
