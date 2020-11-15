import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class ReadTripsForVehicle implements UseCase<List<Trip>, Params> {
  final VehicleRepository repository;

  ReadTripsForVehicle(this.repository);

  @override
  Future<Either<Failure, List<Trip>>> call(Params params) async {
    return await repository.getTripsForVehicleID(params.vehicleID);
  }
}

class Params extends Equatable {
  final int vehicleID;

  Params({@required this.vehicleID});

  @override
  List<Object> get props => [vehicleID];
}
