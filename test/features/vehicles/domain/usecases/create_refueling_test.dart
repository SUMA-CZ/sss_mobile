import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model_create_dto.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_refueling.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  CreateRefueling usecase;
  MockVehicleRepository repository;

  setUp(() {
    repository = MockVehicleRepository();
    usecase = CreateRefueling(repository: repository);
  });

  var objects = <RefuelingModel>[];
  for (var j in json.decode(fixture('refuelings.json'))) {
    objects.add(RefuelingModel.fromJson(j));
  }

  final model = RefuelingModelCreateDTO()..base64Image = 'test';

  final vehicleID = 1;

  test(
    'should crete repo for vehicle from repository',
    () async {
      // arrange
      when(repository.createRefuelingForVehicleID(vehicleID, model))
          .thenAnswer((_) async => Right(objects));
      // act
      final result = await usecase(Params(vehicleID: vehicleID, refueling: model));
      // assert
      expect(result, Right(objects));
      verify(repository.createRefuelingForVehicleID(vehicleID, model));
      verifyNoMoreInteractions(repository);
    },
  );
}
