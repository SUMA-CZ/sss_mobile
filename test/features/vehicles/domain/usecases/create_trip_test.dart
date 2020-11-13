import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_trip.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  CreateTrip usecase;
  MockVehicleRepository mockVehicleRepository;

  setUp(() {
    mockVehicleRepository = MockVehicleRepository();
    usecase = CreateTrip(repository: mockVehicleRepository);
  });

  var objects = <TripModel>[];
  for (var j in json.decode(fixture('refuelings.json'))) {
    objects.add(TripModel.fromJson(j));
  }

  final vehicleID = 1;

  test(
    'should crete repo for vehicle from repository',
    () async {
      // arrange
      // when(mockVehicleRepository.getTripsForVehicleID(any)).thenAnswer((_) async => Right(objects));
      when(mockVehicleRepository.createTripForVehicleID(vehicleID, objects.first))
          .thenAnswer((_) async => Right(objects));
      // act
      final result = await usecase(Params(vehicleID: vehicleID, trip: objects.first));
      // assert
      expect(result, Right(objects));
      verify(mockVehicleRepository.createTripForVehicleID(vehicleID, objects.first));
      verifyNoMoreInteractions(mockVehicleRepository);
    },
  );
}
