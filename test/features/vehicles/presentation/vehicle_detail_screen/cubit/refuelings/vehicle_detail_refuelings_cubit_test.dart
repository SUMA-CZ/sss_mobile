import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_refuelings_for_vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/refuelings/vehicle_detail_refuelings_cubit.dart';

import '../../../../../../fixtures/fixture_reader.dart';

class MockGetRefuelingsForVehicle extends Mock implements GetRefuelingsForVehicle {}

void main() {
  VehicleDetailRefuelingsCubit cubit;
  MockGetRefuelingsForVehicle mockGetRefuelingsForVehicle;
  Vehicle vehicle;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockGetRefuelingsForVehicle = MockGetRefuelingsForVehicle();
    cubit = VehicleDetailRefuelingsCubit(usecase: mockGetRefuelingsForVehicle, vehicle: vehicle);
  });

  var tTrips = <Refueling>[];
  for (var j in jsonDecode(fixture('refuelings.json'))) {
    tTrips.add(RefuelingModel.fromJson(j));
  }

  group('getTrips', () {
    final successEither = tTrips;
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
        expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2));

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
        expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2));

        // act
        cubit.getRefuelings();
      },
    );
  });
}
