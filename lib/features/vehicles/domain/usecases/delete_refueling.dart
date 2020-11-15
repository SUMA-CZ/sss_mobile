import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class DeleteRefueling implements UseCase<void, ParamsForDeletingRefueling> {
  final VehicleRepository repository;

  DeleteRefueling(this.repository);

  @override
  Future<Either<Failure, void>> call(ParamsForDeletingRefueling params) async {
    return await repository.deleteRefueling(params.vehicleID, params.objectID);
  }
}

class ParamsForDeletingRefueling extends Equatable {
  final int vehicleID;
  final int objectID;

  ParamsForDeletingRefueling({@required this.vehicleID, this.objectID});

  @override
  List<Object> get props => [vehicleID, objectID];
}
