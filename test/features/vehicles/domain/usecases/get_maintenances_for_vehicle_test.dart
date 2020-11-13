import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/features/vehicles/data/models/maintenance_model.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_maintenances_for_vehicle.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  GetMaintenancesForVehicle usecase;
  MockVehicleRepository repository;

  setUp(() {
    repository = MockVehicleRepository();
    usecase = GetMaintenancesForVehicle(repository);
  });

  var objects = <MaintenanceModel>[];
  for (var j in json.decode(fixture('maintenances.json'))) {
    objects.add(MaintenanceModel.fromJson(j));
  }

  final vehicleID = 1;

  test(
    'should get maintenances from repository',
    () async {
      // arrange
      when(repository.getMaintenancesForVehicleID(any)).thenAnswer((_) async => Right(objects));
      // act
      final result = await usecase(Params(vehicleID: vehicleID));
      // assert
      expect(result, Right(objects));
      verify(repository.getMaintenancesForVehicleID(vehicleID));
      verifyNoMoreInteractions(repository);
    },
  );
}
