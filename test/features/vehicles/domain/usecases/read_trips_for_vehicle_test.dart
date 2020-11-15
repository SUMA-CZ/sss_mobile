import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_trips_for_vehicle.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  ReadTripsForVehicle usecase;
  MockVehicleRepository repository;

  setUp(() {
    repository = MockVehicleRepository();
    usecase = ReadTripsForVehicle(repository);
  });

  final tTrips = [
    Trip()
      ..id = 1
      ..beginOdometer = 1
      ..endOdometer = 2
      ..officialTrip = true,
    Trip()
      ..id = 2
      ..beginOdometer = 1
      ..endOdometer = 2
      ..officialTrip = true,
  ];

  final vehicleID = 1;

  test(
    'should get trips for vehicle from repository',
    () async {
      // arrange
      when(repository.getTripsForVehicleID(any)).thenAnswer((_) async => Right(tTrips));
      // act
      final result = await usecase(Params(vehicleID: vehicleID));
      // assert
      expect(result, Right(tTrips));
      verify(repository.getTripsForVehicleID(vehicleID));
      verifyNoMoreInteractions(repository);
    },
  );
}
