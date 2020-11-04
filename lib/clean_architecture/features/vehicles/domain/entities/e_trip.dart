import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'e_user.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'e_trip.g.dart';

@JsonSerializable(explicitToJson: true)
class ETrip extends Equatable {
  ETrip();

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'InitialOdometer')
  int beginOdometer;

  @JsonKey(name: 'FinalOdometer')
  int endOdometer;

  @JsonKey(name: 'OfficialJourney')
  bool officialTrip;

  @JsonKey(name: 'ParkingNote')
  String parkingNote;

  @JsonKey(name: 'Note')
  String note;

  @JsonKey(name: 'Latitude')
  double latitude;

  @JsonKey(name: 'Longtitude')
  double longitude;

  @JsonKey(name: 'FuelStatus')
  int fuelStatus;

  @JsonKey(name: 'FromDate')
  DateTime beginDate;

  @JsonKey(name: 'ToDate')
  DateTime endDate;

  @JsonKey(name: 'User')
  EUser user;

  factory ETrip.fromJson(Map<String, dynamic> json) => _$ETripFromJson(json);

  Map<String, dynamic> toJson() => _$ETripToJson(this);

  @override
  List<Object> get props => [
        id,
        beginDate,
        endOdometer,
        officialTrip,
        parkingNote,
        note,
        latitude,
        longitude,
        fuelStatus,
        beginDate,
        endDate,
        user
      ];
}
