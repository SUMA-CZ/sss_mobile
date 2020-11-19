// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map json) {
  return Currency()
    ..id = json['Id'] as int
    ..code = json['Code'] as String
    ..country = json['Country'] as String;
}

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'Id': instance.id,
      'Code': instance.code,
      'Country': instance.country,
    };
