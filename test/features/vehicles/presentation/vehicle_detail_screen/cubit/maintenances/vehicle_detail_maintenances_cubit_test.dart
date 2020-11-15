import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/models/maintenance_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_maintenances_for_vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/maintenances/vehicle_detail_maintenances_cubit.dart';

import '../../../../../../fixtures/fixture_reader.dart';

class MockGetMaintenancesForVehicle extends Mock implements GetMaintenancesForVehicle {}

void main() {
  VehicleDetailMaintenancesCubit cubit;
  MockGetMaintenancesForVehicle mockGetMaintenancesForVehicle;
  Vehicle vehicle;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockGetMaintenancesForVehicle = MockGetMaintenancesForVehicle();
    cubit = VehicleDetailMaintenancesCubit(
        getMaintenancesForTrip: mockGetMaintenancesForVehicle, vehicle: vehicle);
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
        cubit.getMaintenances();
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
        final expected = [
          VehicleDetailMaintenancesLoading(),
          VehicleDetailMaintenancesLoaded(successEither)
        ];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.getMaintenances();
      },
    );

    test(
      'should [Loading, Error] when fails',
      () async {
        // arrange
        when(mockGetMaintenancesForVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // act

        final expected = [VehicleDetailMaintenancesLoading(), VehicleDetailMaintenancesError()];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.getMaintenances();
      },
    );
  });
}
