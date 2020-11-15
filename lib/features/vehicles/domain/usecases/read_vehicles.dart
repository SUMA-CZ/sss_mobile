import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class ReadVehicles implements UseCase<List<Vehicle>, NoParams> {
  final VehicleRepository repository;

  ReadVehicles(this.repository);

  @override
  Future<Either<Failure, List<Vehicle>>> call(NoParams params) async {
    return await repository.getVehicles();
  }
}
