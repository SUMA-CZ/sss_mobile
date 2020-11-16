import 'package:dartz/dartz.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/core/usecases/usecase.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vat_rate.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vat_rate_repository.dart';

class ReadVatRates implements UseCase<List<VatRate>, NoParamsReadVat> {
  final VatRateRepository repository;

  ReadVatRates(this.repository);

  @override
  Future<Either<Failure, List<VatRate>>> call(NoParamsReadVat params) async {
    return await repository.readAll();
  }
}

class NoParamsReadVat {}
