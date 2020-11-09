import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_vehicles.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  GetVehicles usecase;
  MockVehicleRepository repository;

  setUp(() {
    repository = MockVehicleRepository();
    usecase = GetVehicles(repository);
  });

  final tVehicles = [Vehicle(id: 1, spz: 'A'), Vehicle(id: 2, spz: 'B')];

  test(
    'should get vehicles from repository',
    () async {
      // arrange
      when(repository.getVehicles()).thenAnswer((_) async => Right(tVehicles));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tVehicles));
      verify(repository.getVehicles());
      verifyNoMoreInteractions(repository);
    },
  );
}
