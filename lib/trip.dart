import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/user.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'trip.g.dart';

//{
//"Id": 2643,
//"InitialOdometer": 5,
//"FinalOdometer": 6,
//"OfficialJourney": true,
//"ParkingNote": "sample string 10",
//"Latitude": 11.1,
//"Longtitude": 12.1,
//"Note": "sample string 8",
//"FuelStatus": 9,
//"User": {
//"Id": "41be89d0-16e4-4133-a941-f6c98273bed7",
//"Email": "tomas.sykora@ajty.cz",
//"Name": "Syky"
//},
//"FromDate": "2016-09-05T07:50:41.953",
//"ToDate": "2016-09-05T07:50:41.953"
//}

@JsonSerializable()
class Trip {
  Trip();

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
  User user;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TripToJson(this);
}