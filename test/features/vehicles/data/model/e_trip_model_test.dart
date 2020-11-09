import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tTripModel = TripModel()
    ..id = 2643
    ..beginOdometer = 5
    ..endOdometer = 664343
    ..officialTrip = true
    ..parkingNote = "sample string 10"
    ..latitude = 11.1
    ..longitude = 12.1
    ..note = "sample string 8"
    ..fuelStatus = 9
    ..beginDate = DateTime.parse("2016-09-05T07:50:41.953")
    ..endDate = DateTime.parse("2016-09-05T07:50:41.953")
    ..user = (User()
      ..id = "41be89d0-16e4-4133-a941-f6c98273bed7"
      ..vin = "tomas.sykora@ajty.cz"
      ..name = "Syky");

  test(
    'should be a subclass of Trip entity',
    () async {
      // assert
      expect(tTripModel, isA<Trip>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('trip.json'));
        // act
        final result = TripModel.fromJson(jsonMap);
        // assert
        expect(result, tTripModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tTripModel.toJson();
        // assert
        final expectedMap = {
          "Id": 2643,
          "InitialOdometer": 5,
          "FinalOdometer": 664343,
          "OfficialJourney": true,
          "ParkingNote": "sample string 10",
          "Latitude": 11.1,
          "Longtitude": 12.1,
          "Note": "sample string 8",
          "FuelStatus": 9,
          "User": {
            "Id": "41be89d0-16e4-4133-a941-f6c98273bed7",
            "Email": "tomas.sykora@ajty.cz",
            "Name": "Syky"
          },
          "FromDate": "2016-09-05T07:50:41.953",
          "ToDate": "2016-09-05T07:50:41.953"
        };
        expect(result, expectedMap);
      },
    );
  });
}
