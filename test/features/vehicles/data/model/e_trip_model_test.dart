import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_trip_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/vehicle_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_user.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_vehicle.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tVehicleModel = ETripModel()
    ..id = 2643
    ..beginOdometer = 5
    ..endOdometer = 664343
    ..officialTrip = true
    ..parkingNote = "sample string 10"
    ..latitude = 11.1
    ..longitude = 12.1
    ..note = "sample string 8"
    ..fuelStatus = 9
    ..user = (EUser()
      ..id = "41be89d0-16e4-4133-a941-f6c98273bed7"
      ..vin = "tomas.sykora@ajty.cz"
      ..name = "Syky");

  test(
    'should be a subclass of Vehicle entity',
    () async {
      // assert
      expect(tVehicleModel, isA<EVehicle>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('vehicle.json'));
        // act
        final result = VehicleModel.fromJson(jsonMap);
        // assert
        expect(result, tVehicleModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tVehicleModel.toJson();
        // assert
        final expectedMap = {
          "Id": 4,
          "SPZ": "5A54291",
          "VIN": "F2",
          "Name": "Ford Fusion2",
          "Note": "\r\n\r\n2.4.2020 letni pneu",
          "Odometer": 168795,
          "Latitude": 0.0,
          "Longtitude": 0.0,
          "FuelStatus": 100
        };
        expect(result, expectedMap);
      },
    );
  });

  group('toJson and fromJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('vehicle.json'));

        // act
        final fromJson = VehicleModel.fromJson(jsonMap);

        final result = tVehicleModel.toJson();
        final res = VehicleModel.fromJson(result);
        // assert

        expect(fromJson, res);
      },
    );
  });
}
