import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_trip.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/trip/cubit/trip_form_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/trips/vehicle_detail_trips_cubit.dart';

import '../../../../../../fixtures/fixture_reader.dart';

class MockCreateTrip extends Mock implements CreateTrip {}

class MockVehicleTripListCubit extends Mock implements VehicleDetailTripsCubit {}

void main() {
  TripFormCubit cubit;
  MockCreateTrip mockCreateTrip;
  Vehicle vehicle;
  MockVehicleTripListCubit mockVehicleTripListCubit;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockCreateTrip = MockCreateTrip();
    mockVehicleTripListCubit = MockVehicleTripListCubit();
    cubit = TripFormCubit(
        vehicle: vehicle, usecase: mockCreateTrip, tripListCubit: mockVehicleTripListCubit);
  });

  var tTrips = <Trip>[];
  for (var j in jsonDecode(fixture('trips.json'))) {
    tTrips.add(TripModel.fromJson(j));
  }

  group('createTrip', () {
    final successEither = tTrips;
    test(
      'should use Usecase to get data',
      () async {
        // arrange
        when(mockCreateTrip.call(Params(vehicleID: vehicle.id, trip: tTrips.first)))
            .thenAnswer((realInvocation) async => Right(successEither));
        // act
        await cubit.createTrip(tTrips.first);
        // assert
        verify(mockCreateTrip.call(Params(vehicleID: vehicle.id, trip: tTrips.first)));
        verify(mockVehicleTripListCubit.getTrips());
        verifyNoMoreInteractions(mockVehicleTripListCubit);
      },
    );

    test(
      'should [Loading, Loaded] when success ',
      () async {
        // arrange
        when(mockCreateTrip.call(Params(vehicleID: vehicle.id, trip: tTrips.first)))
            .thenAnswer((realInvocation) async => Right(successEither));
        // act
        final expected = [TripFormLoading(), TripFormCreated()];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.createTrip(tTrips.first);
      },
    );

    test(
      'should [Loading, Error] when fail',
      () async {
        // arrange
        when(mockCreateTrip.call(Params(vehicleID: vehicle.id, trip: tTrips.first)))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // act

        final expected = [TripFormLoading(), TripFormError()];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.createTrip(tTrips.first);
      },
    );
  });
}
