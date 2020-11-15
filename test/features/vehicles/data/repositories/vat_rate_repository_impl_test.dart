import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/vat_rates_datasource.dart';
import 'package:sss_mobile/features/vehicles/data/models/vat_rate_model.dart';
import 'package:sss_mobile/features/vehicles/data/repositories/vat_rate_repository_imp.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vat_rate_repository.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements VatRatesDataSource {}

void main() {
  VatRateRepository repository;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = VatRateRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  // TODO: Refactor
  var tVatRates = <VatRateModel>[];
  for (var j in json.decode(fixture('vatrates.json'))) {
    tVatRates.add(VatRateModel.fromJson(j));
  }

  group('getVehicles', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getAll()).thenAnswer((_) async => tVatRates);
        // act
        final result = await repository.readAll();
        // assert
        verify(mockRemoteDataSource.getAll());
        expect(result, equals(Right(tVatRates)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getAll()).thenThrow(ServerException());
        // act
        final result = await repository.readAll();
        // assert
        verify(mockRemoteDataSource.getAll());
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });
}
