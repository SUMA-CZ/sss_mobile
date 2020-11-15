import 'package:dio/dio.dart';
import 'package:sss_mobile/features/vehicles/data/models/vat_rate_model.dart';

abstract class VatRateDataSource {
  Future<List<VatRateModel>> getAll();
}

class VatRateDataSourceImpl implements VatRateDataSource {
  final Dio client;

  VatRateDataSourceImpl({this.client});

  @override
  Future<List<VatRateModel>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
