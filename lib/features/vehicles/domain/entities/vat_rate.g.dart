// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vat_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VatRate _$VatRateFromJson(Map json) {
  return VatRate()
    ..id = json['Id'] as int
    ..vat = json['VAT'] as String;
}

Map<String, dynamic> _$VatRateToJson(VatRate instance) => <String, dynamic>{
      'Id': instance.id,
      'VAT': instance.vat,
    };
