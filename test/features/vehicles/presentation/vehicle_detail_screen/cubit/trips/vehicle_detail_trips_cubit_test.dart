import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_trip.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_trips_for_vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/trips/trips_cubit.dart';

import '../../../../../../fixtures/fixture_reader.dart';

class MockGetTripsForVehicle extends Mock implements ReadTripsForVehicle {}

class MockDeleteTrip extends Mock implements DeleteTrip {}

void main() {
  TripsCubit cubit;
  MockGetTripsForVehicle mockGetTripsForVehicle;
  Vehicle vehicle;
  MockDeleteTrip mockDeleteTrip;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockGetTripsForVehicle = MockGetTripsForVehicle();
    mockDeleteTrip = MockDeleteTrip();
    cubit = TripsCubit(
        deleteTrip: mockDeleteTrip, getTripsForVehicle: mockGetTripsForVehicle, vehicle: vehicle);
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
        final expected = [TripsStateLoading(), TripsStateLoaded(successEither)];

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

        final expected = [TripsStateLoading(), TripsStateError()];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.getTrips();
      },
    );
  });

  group('deleteTrip', () {
    final maintenanceID = 1;
    test(
      'should use delete and getMaintenances usecases to get data',
      () async {
        // arrange
        when(mockDeleteTrip
                .call(ParamsForDeleteTrip(vehicleID: vehicle.id, objectID: maintenanceID)))
            .thenAnswer((realInvocation) async => Right(null));

        when(mockGetTripsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(tTrips));
        // act
        await cubit.delete(1);
        // assert
        verify(mockDeleteTrip
            .call(ParamsForDeleteTrip(vehicleID: vehicle.id, objectID: maintenanceID)));
        verify(mockGetTripsForVehicle.call(Params(vehicleID: vehicle.id)));
      },
    );

    test(
      'should [Loading, Deleted, Loading, Loaded] when success deleting',
      () async {
        // arrange
        when(mockDeleteTrip
                .call(ParamsForDeleteTrip(vehicleID: vehicle.id, objectID: maintenanceID)))
            .thenAnswer((realInvocation) async => Right(null));

        when(mockGetTripsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(tTrips));

        final expected = [
          TripsStateLoading(),
          TripsStateDeleted(),
          TripsStateLoading(),
          TripsStateLoaded(tTrips)
        ];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        await cubit.delete(1);
        // assert
      },
    );

    test(
      'should [Loading, ErrorDeleting, Loading, Loaded] when success deleting',
      () async {
        // arrange
        when(mockDeleteTrip
                .call(ParamsForDeleteTrip(vehicleID: vehicle.id, objectID: maintenanceID)))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));

        when(mockGetTripsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(tTrips));

        final expected = [
          TripsStateLoading(),
          TripsStateErrorDeleting(),
          TripsStateLoading(),
          TripsStateLoaded(tTrips)
        ];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        await cubit.delete(1);
        // assert
      },
    );
  });
}
