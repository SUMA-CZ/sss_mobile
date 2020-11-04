import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/models/user.dart';

part 'refueling.g.dart';

@JsonSerializable()
class Refueling extends Equatable {
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

  @override
  // TODO: implement props
  List<Object> get props => [id];

  factory Refueling.fromJson(Map<String, dynamic> json) => _$RefuelingFromJson(json);

  Map<String, dynamic> toJson() => _$RefuelingToJson(this);
}
