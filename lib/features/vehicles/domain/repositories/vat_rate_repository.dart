import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vat_rate.dart';

abstract class VatRateRepository {
  Future<Either<Failure, List<VatRate>>> readAll();
}
