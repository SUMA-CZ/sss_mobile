import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_refuelings_for_vehicle.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  GetRefuelingsForVehicle usecase;
  MockVehicleRepository repository;

  setUp(() {
    repository = MockVehicleRepository();
    usecase = GetRefuelingsForVehicle(repository);
  });

  var objects = <RefuelingModel>[];
  for (var j in json.decode(fixture('refuelings.json'))) {
    objects.add(RefuelingModel.fromJson(j));
  }

  final vehicleID = 1;

  test(
    'should get trips for trips from repository',
    () async {
      // arrange
      when(repository.getRefuelingsForVehicleID(any)).thenAnswer((_) async => Right(objects));
      // act
      final result = await usecase(Params(vehicleID: vehicleID));
      // assert
      expect(result, Right(objects));
      verify(repository.getRefuelingsForVehicleID(vehicleID));
      verifyNoMoreInteractions(repository);
    },
  );
}
