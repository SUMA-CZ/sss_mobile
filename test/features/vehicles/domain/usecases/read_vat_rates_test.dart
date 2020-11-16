import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/features/vehicles/data/models/vat_rate_model.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vat_rate_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_vat_rates.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRepo extends Mock implements VatRateRepository {}

void main() {
  ReadVatRates usecase;
  MockRepo repository;

  setUp(() {
    repository = MockRepo();
    usecase = ReadVatRates(repository);
  });

  var tVatRates = <VatRateModel>[];
  for (var j in json.decode(fixture('vatrates.json'))) {
    tVatRates.add(VatRateModel.fromJson(j));
  }

  test(
    'should get vehicles from repository',
    () async {
      // arrange
      when(repository.readAll()).thenAnswer((_) async => Right(tVatRates));
      // act
      final result = await usecase(NoParamsReadVat());
      // assert
      expect(result, Right(tVatRates));
      verify(repository.readAll());
      verifyNoMoreInteractions(repository);
    },
  );
}
