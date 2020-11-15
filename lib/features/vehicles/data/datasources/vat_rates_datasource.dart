import 'package:dio/dio.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/features/vehicles/data/models/vat_rate_model.dart';

import '../../../../env_config.dart';

abstract class VatRatesDataSource {
  Future<List<VatRateModel>> getAll();
}

class VatRatesDataSourceImpl implements VatRatesDataSource {
  final Dio client;

  VatRatesDataSourceImpl({this.client});

  @override
  Future<List<VatRateModel>> getAll() async {
    try {
      var vatRates = <VatRateModel>[];
      final response = await client.get('${EnvConfig.API_URL}/vat');
      for (var j in response.data) {
        vatRates.add(VatRateModel.fromJson(j));
      }
      return vatRates;
    } catch (e) {
      throw ServerException();
    }
  }
}
