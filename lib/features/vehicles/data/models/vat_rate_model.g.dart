// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vat_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VatRateModel _$VatRateModelFromJson(Map json) {
  return VatRateModel()
    ..id = json['Id'] as String
    ..vat = json['VAT'] as String;
}

Map<String, dynamic> _$VatRateModelToJson(VatRateModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'VAT': instance.vat,
    };
