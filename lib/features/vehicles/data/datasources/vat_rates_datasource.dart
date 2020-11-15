import 'package:dio/dio.dart';
import 'package:sss_mobile/features/vehicles/data/models/vat_rate_model.dart';

abstract class VatRatesDataSource {
  Future<List<VatRateModel>> getAll();
}

class VatRatesDataSourceImpl implements VatRatesDataSource {
  final Dio client;

  VatRatesDataSourceImpl({this.client});

  @override
  Future<List<VatRateModel>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
