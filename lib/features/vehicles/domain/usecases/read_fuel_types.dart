import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/fuel_type.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/fuel_type_repository.dart';

class ReadFuelTypes implements UseCase<List<FuelType>, NoParams> {
  final FuelTypeRepository repository;

  ReadFuelTypes(this.repository);

  @override
  Future<Either<Failure, List<FuelType>>> call(NoParams params) async {
    return await repository.readAll();
  }
}

class NoParams {}
