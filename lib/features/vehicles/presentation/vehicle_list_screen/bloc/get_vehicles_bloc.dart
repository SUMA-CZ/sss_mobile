import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_vehicles.dart';

part 'get_vehicles_event.dart';
part 'get_vehicles_state.dart';

class GetVehiclesBloc extends Bloc<GetVehiclesEvent, GetVehiclesState> {
  GetVehiclesBloc({@required this.getVehicles})
      : assert(getVehicles != null),
        super(GetVehiclesInitial());

  final GetVehicles getVehicles;

  @override
  Stream<GetVehiclesState> mapEventToState(GetVehiclesEvent event) async* {
    if (event is GetVehiclesEventGetVehicles) {
      yield GetVehiclesStateLoading();
      final failureOrVehicles = await getVehicles(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrVehicles);
    }
  }

  Stream<GetVehiclesState> _eitherLoadedOrErrorState(
      Either<Failure, List<Vehicle>> failureOrVehicles) async* {
    yield failureOrVehicles.fold(
      (failure) => GetVehiclesStateError(message: _mapFailureToMessage(failure)),
      (vehicles) => GetVehiclesStateLoaded(vehicles: vehicles),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'SERVER_FAILURE_MESSAGE';
      default:
        return 'Unexpected error';
    }
  }
}
