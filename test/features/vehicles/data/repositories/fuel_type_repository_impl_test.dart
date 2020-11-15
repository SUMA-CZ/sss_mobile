import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/fuel_types_datasource.dart';
import 'package:sss_mobile/features/vehicles/data/models/fuel_type_model.dart';
import 'package:sss_mobile/features/vehicles/data/repositories/fuel_type_repository_impl.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/fuel_type_repository.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements FuelTypesDataSource {}

void main() {
  FuelTypeRepository repository;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = FuelTypeRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  var tFuelTypes = <FuelTypeModel>[];
  for (var j in json.decode(fixture('fueltypes.json'))) {
    tFuelTypes.add(FuelTypeModel.fromJson(j));
  }

  group('getVehicles', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getAll()).thenAnswer((_) async => tFuelTypes);
        // act
        final result = await repository.readAll();
        // assert
        verify(mockRemoteDataSource.getAll());
        expect(result, equals(Right(tFuelTypes)));
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
