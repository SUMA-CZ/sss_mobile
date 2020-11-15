import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class DeleteMaintenance implements UseCase<void, ParamsForDeletingMaintenance> {
  final VehicleRepository repository;

  DeleteMaintenance(this.repository);

  @override
  Future<Either<Failure, void>> call(ParamsForDeletingMaintenance params) async {
    return await repository.deleteMaintenance(params.vehicleID, params.objectID);
  }
}

class ParamsForDeletingMaintenance extends Equatable {
  final int vehicleID;
  final int objectID;

  ParamsForDeletingMaintenance({@required this.vehicleID, this.objectID});

  @override
  List<Object> get props => [vehicleID, objectID];
}
