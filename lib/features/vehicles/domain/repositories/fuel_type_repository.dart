import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/fuel_type.dart';

abstract class FuelTypeRepository {
  Future<Either<Failure, List<FuelType>>> readAll();
}
