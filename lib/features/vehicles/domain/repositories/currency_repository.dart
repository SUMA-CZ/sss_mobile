import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/currency.dart';

abstract class CurrencyRepository {
  Future<Either<Failure, List<Currency>>> readAll();
}
