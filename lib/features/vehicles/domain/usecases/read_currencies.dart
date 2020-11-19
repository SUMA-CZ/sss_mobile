import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/currency.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/currency_repository.dart';

class ReadCurrency implements UseCase<List<Currency>, NoParamsCurrency> {
  final CurrencyRepository repository;

  ReadCurrency(this.repository);

  @override
  Future<Either<Failure, List<Currency>>> call(NoParamsCurrency params) async {
    return await repository.readAll();
  }
}

class NoParamsCurrency {}
