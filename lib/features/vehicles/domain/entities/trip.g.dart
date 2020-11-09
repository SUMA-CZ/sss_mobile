// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$ETripFromJson(Map json) {
  return Trip()
    ..id = json['Id'] as int
    ..beginOdometer = json['InitialOdometer'] as int
    ..endOdometer = json['FinalOdometer'] as int
    ..officialTrip = json['OfficialJourney'] as bool
    ..parkingNote = json['ParkingNote'] as String
    ..note = json['Note'] as String
    ..latitude = (json['Latitude'] as num)?.toDouble()
    ..longitude = (json['Longtitude'] as num)?.toDouble()
    ..fuelStatus = json['FuelStatus'] as int
    ..beginDate = json['FromDate'] == null ? null : DateTime.parse(json['FromDate'] as String)
    ..endDate = json['ToDate'] == null ? null : DateTime.parse(json['ToDate'] as String)
    ..user = json['User'] == null
        ? null
        : User.fromJson((json['User'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          ));
}

Map<String, dynamic> _$ETripToJson(Trip instance) => <String, dynamic>{
      'Id': instance.id,
      'InitialOdometer': instance.beginOdometer,
      'FinalOdometer': instance.endOdometer,
      'OfficialJourney': instance.officialTrip,
      'ParkingNote': instance.parkingNote,
      'Note': instance.note,
      'Latitude': instance.latitude,
      'Longtitude': instance.longitude,
      'FuelStatus': instance.fuelStatus,
      'FromDate': instance.beginDate?.toIso8601String(),
      'ToDate': instance.endDate?.toIso8601String(),
      'User': instance.user?.toJson(),
    };
