// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_maintenance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EMaintenance _$EMaintenanceFromJson(Map json) {
  return EMaintenance()
    ..id = json['Id'] as int
    ..date =
        json['Date'] == null ? null : DateTime.parse(json['Date'] as String)
    ..state = json['State'] as String
    ..price = (json['Price'] as num)?.toDouble()
    ..description = json['Description'] as String
    ..note = json['Note'] as String
    ..maintenanceLocationId = json['MaintenanceLocationId'] as int
    ..vatRateId = json['VATRateId'] as int
    ..user = json['User'] == null
        ? null
        : EUser.fromJson((json['User'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          ))
    ..scanURL = json['ScanURL'] as String;
}

Map<String, dynamic> _$EMaintenanceToJson(EMaintenance instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Date': instance.date?.toIso8601String(),
      'State': instance.state,
      'Price': instance.price,
      'Description': instance.description,
      'Note': instance.note,
      'MaintenanceLocationId': instance.maintenanceLocationId,
      'VATRateId': instance.vatRateId,
      'User': instance.user?.toJson(),
      'ScanURL': instance.scanURL,
    };
