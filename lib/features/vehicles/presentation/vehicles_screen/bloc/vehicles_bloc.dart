import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_vehicles.dart';

part 'vehicles_event.dart';
part 'vehicles_state.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  VehiclesBloc({@required this.getVehicles})
      : assert(getVehicles != null),
        super(VehiclesStateInitial());

  final ReadVehicles getVehicles;

  @override
  Stream<VehiclesState> mapEventToState(VehiclesEvent event) async* {
    if (event is VehiclesEventRead) {
      yield VehiclesStateLoading();
      final failureOrVehicles = await getVehicles(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrVehicles);
    }
  }

  Stream<VehiclesState> _eitherLoadedOrErrorState(
      Either<Failure, List<Vehicle>> failureOrVehicles) async* {
    yield failureOrVehicles.fold(
      (failure) => VehiclesStateError(message: _mapFailureToMessage(failure)),
      (vehicles) => VehiclesStateLoaded(vehicles: vehicles),
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
