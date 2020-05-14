// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return Vehicle()
    ..id = json['Id'] as int
    ..vin = json['VIN'] as String
    ..spz = json['SPZ'] as String
    ..name = json['Name'] as String
    ..note = json['Note'] as String
    ..odometer = (json['Odometer'] as num)?.toDouble()
    ..latitude = (json['Latitude'] as num)?.toDouble()
    ..longitude = (json['Longtitude'] as num)?.toDouble()
    ..fuelStatus = json['FuelStatus'] as int
    ..trips = (json['trips'] as List)
        ?.map(
            (e) => e == null ? null : Trip.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..maintenance = (json['maintenance'] as List)
        ?.map((e) =>
    e == null ? null : Maintenance.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..refueling = (json['refueling'] as List)
        ?.map((e) =>
    e == null ? null : Refueling.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'Id': instance.id,
      'VIN': instance.vin,
      'SPZ': instance.spz,
      'Name': instance.name,
      'Note': instance.note,
      'Odometer': instance.odometer,
      'Latitude': instance.latitude,
      'Longtitude': instance.longitude,
      'FuelStatus': instance.fuelStatus,
  'trips': instance.trips,
  'maintenance': instance.maintenance,
  'refueling': instance.refueling,
    };
