import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/models/vehicle_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/vehicle_detail_cubit.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockGetVehicle extends Mock implements ReadVehicle {}

void main() {
  VehicleDetailCubit cubit;
  Vehicle vehicle;
  MockGetVehicle mockGetVehicle;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockGetVehicle = MockGetVehicle();
    cubit = VehicleDetailCubit(vehicle: vehicle, usecase: mockGetVehicle);
  });

  test(
    'should be intitial with vehicle',
    () async {
      expect(cubit.state, VehicleDetailStateInitial(vehicle: vehicle));
    },
  );

  final tVehicle = VehicleModel.fromJson(jsonDecode(fixture('vehicle.json')));

  group('getVehicle', () {
    final successEither = tVehicle;
    test(
      'should use Usecase to get data',
      () async {
        // arrange
        when(mockGetVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(successEither));
        // act
        cubit.readVehicle();
        // assert
        verify(mockGetVehicle.call(Params(vehicleID: vehicle.id)));
      },
    );

    test(
      'should [Loading, Loaded] when success ',
      () async {
        // arrange
        when(mockGetVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Right(successEither));
        // act
        final expected = [
          VehicleDetailStateLoading(),
          VehicleDetailStateInitial(vehicle: tVehicle)
        ];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.readVehicle();
      },
    );

    test(
      'should [Loading, Error] when fail',
      () async {
        // arrange
        when(mockGetVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // act

        final expected = [VehicleDetailStateLoading(), VehicleDetailStateInitial(vehicle: vehicle)];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.readVehicle();
      },
    );
  });

  //TODO: add test
}
