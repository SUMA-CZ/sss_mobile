import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_user.dart';
import 'package:sss_mobile/models/user.dart';

part 'e_refueling.g.dart';

@JsonSerializable()
class ERefueling extends Equatable {
  ERefueling();

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
  EUser user;

  @JsonKey(name: 'ScanURL')
  String scanURL;

  @override
  // TODO: implement props
  List<Object> get props => [id];

  factory ERefueling.fromJson(Map<String, dynamic> json) => _$ERefuelingFromJson(json);

  Map<String, dynamic> toJson() => _$ERefuelingToJson(this);
}
