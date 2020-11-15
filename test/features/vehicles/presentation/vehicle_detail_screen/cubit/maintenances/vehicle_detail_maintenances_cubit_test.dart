import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/models/maintenance_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_maintenances_for_vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/maintenances/maintenances_cubit.dart';

import '../../../../../../fixtures/fixture_reader.dart';

class MockGetMaintenancesForVehicle extends Mock implements ReadMaintenancesForVehicle {}

class MockDeleteMaintenance extends Mock implements DeleteMaintenance {}

void main() {
  MaintenancesCubit cubit;
  MockGetMaintenancesForVehicle mockGetMaintenancesForVehicle;
  MockDeleteMaintenance mockDeleteMaintenance;
  Vehicle vehicle;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockGetMaintenancesForVehicle = MockGetMaintenancesForVehicle();
    mockDeleteMaintenance = MockDeleteMaintenance();
    cubit = MaintenancesCubit(
        deleteMaintenance: mockDeleteMaintenance,
        getMaintenancesForTrip: mockGetMaintenancesForVehicle,
        vehicle: vehicle);
  });

  var tTrips = <Maintenance>[];
  for (var j in jsonDecode(fixture('maintenances.json'))) {
    tTrips.add(MaintenanceModel.fromJson(j));
  }

  group('getMaintenances', () {
    final successEither = tTrips;
    test(
      'should use Usecase to get data',
      () async {
        // arrange
        when(mockGetMaintenancesForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(successEither));
        // act
        cubit.read();
        // assert
        verify(mockGetMaintenancesForVehicle.call(Params(vehicleID: vehicle.id)));
      },
    );

    test(
      'should [Loading, Loaded] when success ',
      () async {
        // arrange
        when(mockGetMaintenancesForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(successEither));
        // act
        final expected = [MaintenancesStateLoading(), MaintenancesStateLoaded(successEither)];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.read();
      },
    );

    test(
      'should [Loading, Error] when fails',
      () async {
        // arrange
        when(mockGetMaintenancesForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // act

        final expected = [MaintenancesStateLoading(), MaintenancesStateError()];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.read();
      },
    );
  });

  group('deleteMaintenance', () {
    final maintenanceID = 1;
    test(
      'should use delete and getMaintenances usecases to get data',
      () async {
        // arrange
        when(mockDeleteMaintenance
                .call(ParamsForDeletingMaintenance(vehicleID: vehicle.id, objectID: maintenanceID)))
            .thenAnswer((realInvocation) async => Right(null));

        when(mockGetMaintenancesForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(tTrips));
        // act
        await cubit.delete(1);
        // assert
        verify(mockDeleteMaintenance
            .call(ParamsForDeletingMaintenance(vehicleID: vehicle.id, objectID: maintenanceID)));
        verify(mockGetMaintenancesForVehicle.call(Params(vehicleID: vehicle.id)));
      },
    );

    test(
      'should [Loading, Deleted, Loading, Loaded] when success deleting',
      () async {
        // arrange
        when(mockDeleteMaintenance
                .call(ParamsForDeletingMaintenance(vehicleID: vehicle.id, objectID: maintenanceID)))
            .thenAnswer((realInvocation) async => Right(null));

        when(mockGetMaintenancesForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(tTrips));

        final expected = [
          MaintenancesStateLoading(),
          MaintenancesStateDeleted(),
          MaintenancesStateLoading(),
          MaintenancesStateLoaded(tTrips)
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
        when(mockDeleteMaintenance
                .call(ParamsForDeletingMaintenance(vehicleID: vehicle.id, objectID: maintenanceID)))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));

        when(mockGetMaintenancesForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(tTrips));

        final expected = [
          MaintenancesStateLoading(),
          MaintenancesStateErrorDeleting(),
          MaintenancesStateLoading(),
          MaintenancesStateLoaded(tTrips)
        ];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        await cubit.delete(1);
        // assert
      },
    );
  });
}
