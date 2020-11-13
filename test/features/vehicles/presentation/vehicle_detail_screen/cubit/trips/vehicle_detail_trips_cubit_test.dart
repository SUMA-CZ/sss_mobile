import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_trips_for_vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/trips/vehicle_detail_trips_cubit.dart';

import '../../../../../../fixtures/fixture_reader.dart';

class MockGetTripsForVehicle extends Mock implements GetTripsForVehicle {}

void main() {
  VehicleDetailTripsCubit cubit;
  MockGetTripsForVehicle mockGetTripsForVehicle;
  Vehicle vehicle;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockGetTripsForVehicle = MockGetTripsForVehicle();
    cubit = VehicleDetailTripsCubit(usecase: mockGetTripsForVehicle, vehicle: vehicle);
  });

  var tTrips = <Trip>[];
  for (var j in jsonDecode(fixture('trips.json'))) {
    tTrips.add(TripModel.fromJson(j));
  }

  group('getTrips', () {
    final successEither = tTrips;
    test(
      'should use Usecase to get data',
      () async {
        // arrange
        when(mockGetTripsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(successEither));
        // act
        cubit.getTrips();
        // assert
        verify(mockGetTripsForVehicle.call(Params(vehicleID: vehicle.id)));
      },
    );

    test(
      'should [Loading, Loaded] when success ',
      () async {
        // arrange
        when(mockGetTripsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(successEither));
        // act
        final expected = [VehicleDetailTripsLoading(), VehicleDetailTripsLoaded(successEither)];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.getTrips();
      },
    );

    test(
      'should [Loading, Error] when fail',
      () async {
        // arrange
        when(mockGetTripsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // act

        final expected = [VehicleDetailTripsLoading(), VehicleDetailTripsError()];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.getTrips();
      },
    );
  });
}
