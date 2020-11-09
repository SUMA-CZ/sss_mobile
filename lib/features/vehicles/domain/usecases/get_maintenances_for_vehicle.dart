import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class GetMaintenancesForVehicle implements UseCase<List<Maintenance>, Params> {
  final VehicleRepository repository;

  GetMaintenancesForVehicle(this.repository);

  @override
  Future<Either<Failure, List<Maintenance>>> call(Params params) async {
    return await repository.getMaintenancesForVehicleID(params.vehicleID);
  }
}

class Params extends Equatable {
  final int vehicleID;

  Params({@required this.vehicleID});

  @override
  List<Object> get props => [vehicleID];
}
