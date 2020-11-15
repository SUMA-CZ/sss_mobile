// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FuelType _$FuelTypeFromJson(Map json) {
  return FuelType()
    ..id = json['Id'] as int
    ..name = json['Name'] as String;
}

Map<String, dynamic> _$FuelTypeToJson(FuelType instance) => <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
    };
