import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/clean_architecture/core/error/failure.dart';
import 'package:sss_mobile/clean_architecture/core/usecases/usecase.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_trip.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/repositories/vehicle_repository.dart';

class GetTripsForVehicle implements UseCase<List<ETrip>, Params> {
  final VehicleRepository repository;

  GetTripsForVehicle(this.repository);

  @override
  Future<Either<Failure, List<ETrip>>> call(Params params) async {
    return await repository.getTripsForVehicles(params.vehicleID);
  }
}

class Params extends Equatable {
  final int vehicleID;

  Params({@required this.vehicleID});

  @override
  List<Object> get props => [vehicleID];
}
