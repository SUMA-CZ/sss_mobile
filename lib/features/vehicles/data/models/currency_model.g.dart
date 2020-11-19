// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyModel _$CurrencyModelFromJson(Map json) {
  return CurrencyModel()
    ..id = json['Id'] as int
    ..code = json['Code'] as String
    ..country = json['Country'] as String;
}

Map<String, dynamic> _$CurrencyModelToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Code': instance.code,
      'Country': instance.country,
    };
