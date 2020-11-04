// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map json) {
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
        ?.map((e) => e == null
            ? null
            : Trip.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList()
    ..maintenance = (json['maintenance'] as List)
        ?.map((e) => e == null
            ? null
            : Maintenance.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList()
    ..refueling = (json['refueling'] as List)
        ?.map((e) => e == null
            ? null
            : Refueling.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
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
      'trips': instance.trips?.map((e) => e?.toJson())?.toList(),
      'maintenance': instance.maintenance?.map((e) => e?.toJson())?.toList(),
      'refueling': instance.refueling?.map((e) => e?.toJson())?.toList(),
    };
