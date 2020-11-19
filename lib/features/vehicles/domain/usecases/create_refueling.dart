import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model_create_dto.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class CreateRefueling implements UseCase<List<Refueling>, Params> {
  final VehicleRepository repository;

  CreateRefueling({@required this.repository}) : assert(repository != null);

  @override
  Future<Either<Failure, List<Refueling>>> call(Params params) async {
    return await repository.createRefuelingForVehicleID(params.vehicleID, params.refueling);
  }
}

class Params extends Equatable {
  final int vehicleID;
  final RefuelingModelCreateDTO refueling;

  Params({@required this.vehicleID, @required this.refueling});

  @override
  List<Object> get props => [vehicleID, refueling];
}
