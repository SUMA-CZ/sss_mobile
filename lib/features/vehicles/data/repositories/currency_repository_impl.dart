import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/currency_datasource.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/currency.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/currency_repository.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final CurrencyDataSource dataSource;

  CurrencyRepositoryImpl({@required this.dataSource});

  @override
  Future<Either<Failure, List<Currency>>> readAll() async {
    try {
      final currencies = await dataSource.getAll();
      return Right(currencies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
