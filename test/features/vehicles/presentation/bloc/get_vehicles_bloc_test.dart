import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/clean_architecture/core/error/failure.dart';
import 'package:sss_mobile/clean_architecture/core/usecases/usecase.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/models/vehicle_model.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/usecases/get_vehicles.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/presentation/bloc/get_vehicles_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGetVehicles extends Mock implements GetVehicles {}

void main() {
  GetVehiclesBloc bloc;
  MockGetVehicles mockGetVehicles;
  setUp(() {
    mockGetVehicles = MockGetVehicles();

    bloc = GetVehiclesBloc(getVehicles: mockGetVehicles);
  });

  test('Initial State should be loading', () {
    expect(bloc.state, equals(GetVehiclesInitial()));
  });

  group('getVehicles', () {
    var tEVehicles = <VehicleModel>[];
    for (var j in json.decode(fixture('vehicles.json'))) {
      tEVehicles.add(VehicleModel.fromJson(j));
    }
    test('should get data from usecase', () async {
      final params = NoParams();

      when(mockGetVehicles(any)).thenAnswer((_) async => Right(tEVehicles));

      bloc.add(GetVehiclesEventGetVehicles());

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
          GetVehiclesStateLoading(),
          GetVehiclesStateLoaded(vehicles: tEVehicles),
        ];
        expectLater(bloc, emitsInOrder(expected)).timeout(Duration(seconds: 2));
        // act
        bloc.add(GetVehiclesEventGetVehicles());
      },
    );

    final String tMessage = "SERVER_FAILURE_MESSAGE";

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetVehicles(any)).thenAnswer((_) async => Left(ServerFailure(message: tMessage)));
        // assert later
        final expected = [
          GetVehiclesStateLoading(),
          GetVehiclesStateError(message: tMessage),
        ];
        expectLater(bloc, emitsInOrder(expected)).timeout(Duration(seconds: 2));
        // act
        bloc.add(GetVehiclesEventGetVehicles());
      },
    );
  });
}
