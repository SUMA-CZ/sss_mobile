import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/models/vehicle_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/vehicle_detail_cubit.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

class MockGetVehicle extends Mock implements GetVehicle {}

void main() {
  VehicleDetailCubit cubit;
  MockVehicleRepository mockVehicleRepository;
  Vehicle vehicle;
  MockGetVehicle mockGetVehicle;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockVehicleRepository = MockVehicleRepository();
    mockGetVehicle = MockGetVehicle();
    cubit = VehicleDetailCubit(
        vehicleRepository: mockVehicleRepository, vehicle: vehicle, usecase: mockGetVehicle);
  });

  test(
    'should be intitial with vehicle',
    () async {
      expect(cubit.state, VehicleDetailInitial(vehicle: vehicle));
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
        cubit.getVehicle();
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
        final expected = [VehicleDetailLoading(), VehicleDetailInitial(vehicle: tVehicle)];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.getVehicle();
      },
    );

    test(
      'should [Loading, Error] when fail',
      () async {
        // arrange
        when(mockGetVehicle.call(Params(vehicleID: vehicle.id)))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // act

        final expected = [VehicleDetailLoading(), VehicleDetailInitial(vehicle: vehicle)];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.getVehicle();
      },
    );
  });

  //TODO: add test
}
