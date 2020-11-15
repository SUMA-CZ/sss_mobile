import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/data/models/vehicle_model.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_vehicles.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicles_screen/bloc/vehicles_bloc.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockGetVehicles extends Mock implements ReadVehicles {}

void main() {
  VehiclesBloc bloc;
  MockGetVehicles mockGetVehicles;
  setUp(() {
    mockGetVehicles = MockGetVehicles();

    bloc = VehiclesBloc(getVehicles: mockGetVehicles);
  });

  test('Initial State should be loading', () {
    expect(bloc.state, equals(VehiclesStateInitial()));
  });

  group('getVehicles', () {
    var tEVehicles = <VehicleModel>[];
    for (var j in json.decode(fixture('vehicles.json'))) {
      tEVehicles.add(VehicleModel.fromJson(j));
    }
    test('should get data from usecase', () async {
      final params = NoParams();

      when(mockGetVehicles(any)).thenAnswer((_) async => Right(tEVehicles));

      bloc.add(VehiclesEventRead());

      await untilCalled(mockGetVehicles(params)).timeout(Duration(seconds: 2));
      // assert
      verify(mockGetVehicles(params));
    });

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetVehicles(any)).thenAnswer((_) async => Right(tEVehicles));
        // assert later
        final expected = [
          VehiclesStateLoading(),
          VehiclesStateLoaded(vehicles: tEVehicles),
        ];
        unawaited(expectLater(bloc, emitsInOrder(expected)).timeout(Duration(seconds: 2)));
        // act
        bloc.add(VehiclesEventRead());
      },
    );

    final tMessage = 'SERVER_FAILURE_MESSAGE';

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetVehicles(any)).thenAnswer((_) async => Left(ServerFailure(message: tMessage)));
        // assert later
        final expected = [
          VehiclesStateLoading(),
          VehiclesStateError(message: tMessage),
        ];
        unawaited(expectLater(bloc, emitsInOrder(expected)).timeout(Duration(seconds: 2)));
        // act
        bloc.add(VehiclesEventRead());
      },
    );
  });
}
