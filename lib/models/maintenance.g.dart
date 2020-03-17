// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Maintenance _$MaintenanceFromJson(Map<String, dynamic> json) {
  return Maintenance()
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
        : User.fromJson(json['User'] as Map<String, dynamic>)
    ..scanURL = json['ScanURL'] as String;
}

Map<String, dynamic> _$MaintenanceToJson(Maintenance instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Date': instance.date?.toIso8601String(),
      'State': instance.state,
      'Price': instance.price,
      'Description': instance.description,
      'Note': instance.note,
      'MaintenanceLocationId': instance.maintenanceLocationId,
      'VATRateId': instance.vatRateId,
      'User': instance.user,
      'ScanURL': instance.scanURL,
    };
