import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/models/maintenance.dart';
import 'package:sss_mobile/models/refueling.dart';
import 'package:sss_mobile/models/trip.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'vehicle.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class Vehicle {
  Vehicle();

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'VIN')
  String vin;

  @JsonKey(name: 'SPZ')
  String spz;

  @JsonKey(name: 'Name')
  String name;

  @JsonKey(name: 'Note')
  String note;

  @JsonKey(name: 'Odometer')
  double odometer;

  @JsonKey(name: 'Latitude')
  double latitude;

  @JsonKey(name: 'Longtitude')
  double longitude;

  @JsonKey(name: 'FuelStatus')
  int fuelStatus;

  List<Trip> trips;
  List<Maintenance> maintenance;
  List<Refueling> refueling;


  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}