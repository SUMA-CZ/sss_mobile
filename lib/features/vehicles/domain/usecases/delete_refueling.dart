import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class DeleteRefueling implements UseCase<void, Params> {
  final VehicleRepository repository;

  DeleteRefueling(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.deleteRefueling(params.vehicleID, params.objectID);
  }
}

class Params extends Equatable {
  final int vehicleID;
  final int objectID;

  Params({@required this.vehicleID, this.objectID});

  @override
  List<Object> get props => [vehicleID, objectID];
}
