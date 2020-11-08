import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/e_vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';

class GetVehicles implements UseCase<List<EVehicle>, NoParams> {
  final VehicleRepository repository;

  GetVehicles(this.repository);

  Future<Either<Failure, List<EVehicle>>> call(NoParams params) async {
    return await repository.getVehicles();
  }
}
