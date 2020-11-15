import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/vat_rates_datasource.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vat_rate.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vat_rate_repository.dart';

class VatRateRepositoryImpl extends VatRateRepository {
  final VatRatesDataSource remoteDataSource;

  VatRateRepositoryImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failure, List<VatRate>>> readAll() async {
    try {
      final vatRates = await remoteDataSource.getAll();
      return Right(vatRates);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
