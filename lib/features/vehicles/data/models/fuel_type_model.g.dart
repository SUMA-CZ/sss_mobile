// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FuelTypeModel _$FuelTypeModelFromJson(Map json) {
  return FuelTypeModel()
    ..id = json['Id'] as String
    ..name = json['Name'] as String;
}

Map<String, dynamic> _$FuelTypeModelToJson(FuelTypeModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
    };
