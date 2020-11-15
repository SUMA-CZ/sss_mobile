import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class DeleteTrip implements UseCase<void, ParamsForDeleteTrip> {
  final VehicleRepository repository;

  DeleteTrip(this.repository);

  @override
  Future<Either<Failure, void>> call(ParamsForDeleteTrip params) async {
    return await repository.deleteTrip(params.vehicleID, params.objectID);
  }
}

class ParamsForDeleteTrip extends Equatable {
  final int vehicleID;
  final int objectID;

  ParamsForDeleteTrip({@required this.vehicleID, this.objectID});

  @override
  List<Object> get props => [vehicleID, objectID];
}
