import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class CreateTrip implements UseCase<List<Trip>, Params> {
  final VehicleRepository repository;

  CreateTrip({@required this.repository}) : assert(repository != null);

  Future<Either<Failure, List<Trip>>> call(Params params) async {
    return await repository.createTripForVehicleID(params.vehicleID, params.trip);
  }
}

class Params extends Equatable {
  final int vehicleID;
  final Trip trip;

  Params({@required this.vehicleID, @required this.trip}) : assert(vehicleID != null, trip != null);

  @override
  List<Object> get props => [vehicleID, trip];
}
