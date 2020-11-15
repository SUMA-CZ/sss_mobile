import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_refuelings_for_vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/refuelings/vehicle_detail_refuelings_cubit.dart';

import '../../../../../../fixtures/fixture_reader.dart';

class MockGetRefuelingsForVehicle extends Mock implements GetRefuelingsForVehicle {}

class MockDeleteRefueling extends Mock implements DeleteRefueling {}

void main() {
  VehicleDetailRefuelingsCubit cubit;
  MockGetRefuelingsForVehicle mockGetRefuelingsForVehicle;
  Vehicle vehicle;
  MockDeleteRefueling mockDeleteRefueling;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockGetRefuelingsForVehicle = MockGetRefuelingsForVehicle();
    mockDeleteRefueling = MockDeleteRefueling();
    cubit = VehicleDetailRefuelingsCubit(
        deleteRefueling: mockDeleteRefueling,
        getRefuelingsForVehicle: mockGetRefuelingsForVehicle,
        vehicle: vehicle);
  });

  var tRefuelings = <Refueling>[];
  for (var j in jsonDecode(fixture('refuelings.json'))) {
    tRefuelings.add(RefuelingModel.fromJson(j));
  }

  group('getTrips', () {
    final successEither = tRefuelings;
    test(
      'should use Usecase to get data',
      () async {
        // arrange
        when(mockGetRefuelingsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(successEither));
        // act
        cubit.getRefuelings();
        // assert
        verify(mockGetRefuelingsForVehicle.call(Params(vehicleID: vehicle.id)));
      },
    );

    test(
      'should [Loading, Loaded] when success',
      () async {
        // arrange
        when(mockGetRefuelingsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(successEither));
        // act
        final expected = [
          VehicleDetailRefuelingsLoading(),
          VehicleDetailRefuelingsLoaded(successEither)
        ];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.getRefuelings();
      },
    );

    test(
      'should [Loading, Error] when fail',
      () async {
        // arrange
        when(mockGetRefuelingsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // act

        final expected = [VehicleDetailRefuelingsLoading(), VehicleDetailRefuelingsError()];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.getRefuelings();
      },
    );
  });

  group('deleteRefueling', () {
    final maintenanceID = 1;
    test(
      'should use delete and getMaintenances usecases to get data',
      () async {
        // arrange
        when(mockDeleteRefueling
                .call(ParamsForDeletingRefueling(vehicleID: vehicle.id, objectID: maintenanceID)))
            .thenAnswer((realInvocation) async => Right(null));

        when(mockGetRefuelingsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(tRefuelings));
        // act
        await cubit.delete(1);
        // assert
        verify(mockDeleteRefueling
            .call(ParamsForDeletingRefueling(vehicleID: vehicle.id, objectID: maintenanceID)));
        verify(mockGetRefuelingsForVehicle.call(Params(vehicleID: vehicle.id)));
      },
    );

    test(
      'should [Loading, Deleted, Loading, Loaded] when success deleting',
      () async {
        // arrange
        when(mockDeleteRefueling
                .call(ParamsForDeletingRefueling(vehicleID: vehicle.id, objectID: maintenanceID)))
            .thenAnswer((realInvocation) async => Right(null));

        when(mockGetRefuelingsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(tRefuelings));

        final expected = [
          VehicleDetailRefuelingsLoading(),
          VehicleDetailRefuelingsDeleted(),
          VehicleDetailRefuelingsLoading(),
          VehicleDetailRefuelingsLoaded(tRefuelings)
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
        when(mockDeleteRefueling
                .call(ParamsForDeletingRefueling(vehicleID: vehicle.id, objectID: maintenanceID)))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));

        when(mockGetRefuelingsForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(tRefuelings));

        final expected = [
          VehicleDetailRefuelingsLoading(),
          VehicleDetailRefuelingsErrorDeleting(),
          VehicleDetailRefuelingsLoading(),
          VehicleDetailRefuelingsLoaded(tRefuelings)
        ];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        await cubit.delete(1);
        // assert
      },
    );
  });
}
