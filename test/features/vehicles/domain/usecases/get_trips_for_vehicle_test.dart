import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_trip.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/usecases/get_trips_for_vehicle.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  GetTripsForVehicle usecase;
  MockVehicleRepository repository;

  setUp(() {
    repository = MockVehicleRepository();
    usecase = GetTripsForVehicle(repository);
  });

  final tTrips = [
    ETrip()
      ..id = 1
      ..beginOdometer = 1
      ..endOdometer = 2
      ..officialTrip = true,
    ETrip()
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
