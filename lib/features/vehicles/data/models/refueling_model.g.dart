// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refueling_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefuelingModel _$ERefuelingModelFromJson(Map json) {
  return RefuelingModel()
    ..id = json['Id'] as int
    ..date = json['Date'] == null ? null : DateTime.parse(json['Date'] as String)
    ..odometer = json['OdometerState'] as int
    ..price = (json['PriceIncludingVAT'] as num)?.toDouble()
    ..vatRate = json['VatRate'] as String
    ..currency = json['Currency'] as String
    ..vehicleId = json['VehicleId'] as int
    ..fuelAmount = (json['FuelBulk'] as num)?.toDouble()
    ..official = json['OfficialJourney'] as bool
    ..note = json['Note'] as String
    ..receiptNo = json['ReceiptNumber'] as String
    ..fuelType = json['FuelType'] as String
    ..user = json['User'] == null
        ? null
        : User.fromJson((json['User'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          ))
    ..scanURL = json['ScanURL'] as String;
}

Map<String, dynamic> _$ERefuelingModelToJson(RefuelingModel instance) => <String, dynamic>{
      'Id': instance.id,
      'Date': instance.date?.toIso8601String(),
      'OdometerState': instance.odometer,
      'PriceIncludingVAT': instance.price,
      'VatRate': instance.vatRate,
      'Currency': instance.currency,
      'VehicleId': instance.vehicleId,
      'FuelBulk': instance.fuelAmount,
      'OfficialJourney': instance.official,
      'Note': instance.note,
      'ReceiptNumber': instance.receiptNo,
      'FuelType': instance.fuelType,
      'User': instance.user?.toJson(),
      'ScanURL': instance.scanURL,
    };
