import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sss_mobile/features/vehicles/data/models/maintenance_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tMaintenanceModel = MaintenanceModel()
    ..id = 5
    ..date = DateTime.parse("2017-07-11T00:00:00")
    ..state = "po servisu"
    ..price = 0.0
    ..description = "servis/opravy nahlasenych zavad - vymena chladice, svicek,kabelu."
    ..note = null
    ..maintenanceLocationId = 3
    ..vatRateId = 1
    ..scanURL = "https://sss.suma.guru/api/scans/95"
    ..user = (User()
      ..id = "ada7c020-b0cf-4968-aced-d8d67a4d38ce"
      ..vin = "jakub.jonak@sumanet.cz"
      ..name = "Jakub Jonak");

  test(
    'should be a subclass of Trip entity',
    () async {
      // assert
      expect(tMaintenanceModel, isA<Maintenance>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('maintenance.json'));
        // act
        final result = MaintenanceModel.fromJson(jsonMap);
        // assert
        expect(result, tMaintenanceModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tMaintenanceModel.toJson();
        // assert
        final expectedMap = {
          "Id": 5,
          "Date": "2017-07-11T00:00:00.000",
          "State": "po servisu",
          "Price": 0.0,
          "Description": "servis/opravy nahlasenych zavad - vymena chladice, svicek,kabelu.",
          "Note": null,
          "MaintenanceLocationId": 3,
          "VATRateId": 1,
          "User": {
            "Id": "ada7c020-b0cf-4968-aced-d8d67a4d38ce",
            "Email": "jakub.jonak@sumanet.cz",
            "Name": "Jakub Jonak"
          },
          "ScanURL": "https://sss.suma.guru/api/scans/95"
        };
        expect(result, expectedMap);
      },
    );
  });
}
