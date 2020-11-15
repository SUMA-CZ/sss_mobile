import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/features/vehicles/data/models/fuel_type_model.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/fuel_type_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_fuel_types.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockVehicleRepository extends Mock implements FuelTypeRepository {}

void main() {
  ReadFuelTypes usecase;
  MockVehicleRepository repository;

  setUp(() {
    repository = MockVehicleRepository();
    usecase = ReadFuelTypes(repository);
  });

  var tVatRates = <FuelTypeModel>[];
  for (var j in json.decode(fixture('fueltypes.json'))) {
    tVatRates.add(FuelTypeModel.fromJson(j));
  }

  test(
    'should get vehicles from repository',
    () async {
      // arrange
      when(repository.readAll()).thenAnswer((_) async => Right(tVatRates));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tVatRates));
      verify(repository.readAll());
      verifyNoMoreInteractions(repository);
    },
  );
}
