import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/e_refueling_model.dart';
import 'package:sss_mobile/models/refueling.dart';
import 'package:sss_mobile/models/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tRefuelingModel = ERefuelingModel()
    ..id = 399
    ..date = DateTime(2019, 5, 13, 0, 0, 0)
    ..odometer = 0
    ..price = 1.0
    ..vatRate = '21%'
    ..currency = 'CZK'
    ..vehicleId = 16
    ..fuelAmount = 1.0
    ..official = true
    ..note = null
    ..receiptNo = "2"
    ..fuelType = "Natural 95"
    ..user = (User()
      ..id = "41be89d0-16e4-4133-a941-f6c98273bed7"
      ..vin = "tomas.sykora@ajty.cz"
      ..name = "Syky")
    ..scanURL = "https://sss.suma.guru/api/scans/532";

  test(
    'should be a subclass of Vehicle entity',
    () async {
      // assert
      expect(tRefuelingModel, isA<Refueling>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('refueling.json'));
        // act
        final result = ERefuelingModel.fromJson(jsonMap);
        // assert
        expect(result, tRefuelingModel);
      },
    );
  });
}
