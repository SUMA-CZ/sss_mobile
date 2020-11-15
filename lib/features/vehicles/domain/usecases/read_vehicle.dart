import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class ReadVehicle implements UseCase<Vehicle, Params> {
  final VehicleRepository repository;

  ReadVehicle(this.repository);

  @override
  Future<Either<Failure, Vehicle>> call(Params params) async {
    return await repository.getVehicle(params.vehicleID);
  }
}

class Params extends Equatable {
  final int vehicleID;

  Params({@required this.vehicleID});

  @override
  List<Object> get props => [vehicleID];
}
