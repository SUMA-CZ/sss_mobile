import 'package:meta/meta.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_vehicle.dart';

class VehicleModel extends EVehicle {
  VehicleModel(
      {@required int id,
      @required String spz,
      String vin,
      String name,
      String note,
      double odometer,
      double latitude,
      double longitude,
      int fuelLevel})
      : super(
            id: id,
            spz: spz,
            vin: vin,
            name: name,
            note: note,
            odometer: odometer,
            latitude: latitude,
            longitude: longitude,
            fuelLevel: fuelLevel);

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
        id: json['Id'] as int,
        vin: json['VIN'] as String,
        spz: json['SPZ'] as String,
        name: json['Name'] as String,
        note: json['Note'] as String,
        odometer: (json['Odometer'] as num)?.toDouble(),
        latitude: (json['Latitude'] as num)?.toDouble(),
        longitude: (json['Longtitude'] as num)?.toDouble(),
        fuelLevel: json['FuelStatus'] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'VIN': vin,
      'SPZ': spz,
      'Name': name,
      'Note': note,
      'Odometer': odometer,
      'Latitude': latitude,
      'Longtitude': longitude,
      'FuelStatus': fuelLevel,
    };
  }
}
