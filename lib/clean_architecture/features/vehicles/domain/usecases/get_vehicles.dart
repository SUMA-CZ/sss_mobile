import 'package:dartz/dartz.dart';
import 'package:sss_mobile/clean_architecture/core/error/failure.dart';
import 'package:sss_mobile/clean_architecture/core/usecases/usecase.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/entities/e_vehicle.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/repositories/vehicle_repository.dart';

class GetVehicles implements UseCase<List<EVehicle>, NoParams> {
  final VehicleRepository repository;

  GetVehicles(this.repository);

  @override
  Future<Either<Failure, List<EVehicle>>> call(NoParams params) async {
    return await repository.getVehicles();
  }
}
