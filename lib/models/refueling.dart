import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/models/user.dart';

part 'refueling.g.dart';

@JsonSerializable()
class Refueling {
  Refueling();

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'Date')
  DateTime date;

  @JsonKey(name: 'OdometerState')
  int odometer;

  @JsonKey(name: 'PriceIncludingVAT')
  double price;

  @JsonKey(name: 'VatRate')
  String vatRate;

  @JsonKey(name: 'Currency')
  String currency;

  @JsonKey(name: 'VehicleId')
  int vehicleId;

  @JsonKey(name: 'FuelBulk')
  double fuelAmount;

  @JsonKey(name: 'OfficialJourney')
  bool official;

  @JsonKey(name: 'Note')
  String note;

  @JsonKey(name: 'ReceiptNumber')
  String receiptNo;

  @JsonKey(name: 'FuelType')
  String fuelType;

  @JsonKey(name: 'User')
  User user;

  @JsonKey(name: 'ScanURL')
  String scanURL;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Refueling.fromJson(Map<String, dynamic> json) => _$RefuelingFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RefuelingToJson(this);
}