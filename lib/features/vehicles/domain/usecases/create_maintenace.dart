import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class CreateMaintenance implements UseCase<List<Maintenance>, Params> {
  final VehicleRepository repository;

  CreateMaintenance({@required this.repository}) : assert(repository != null);

  @override
  Future<Either<Failure, List<Maintenance>>> call(Params params) async {
    return await repository.createMaintenanceForVehicleID(params.vehicleID, params.maintenance);
  }
}

class Params extends Equatable {
  final int vehicleID;
  final Maintenance maintenance;

  Params({@required this.vehicleID, @required this.maintenance});

  @override
  List<Object> get props => [vehicleID, maintenance];
}
