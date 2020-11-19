import 'package:dio/dio.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/features/vehicles/data/models/currency_model.dart';

import '../../../../env_config.dart';

abstract class CurrencyDataSource {
  Future<List<CurrencyModel>> getAll();
}

class CurrencyDataSourceImpl implements CurrencyDataSource {
  final Dio client;

  CurrencyDataSourceImpl({this.client});

  @override
  Future<List<CurrencyModel>> getAll() async {
    try {
      var Currency = <CurrencyModel>[];
      final response = await client.get('${EnvConfig.API_URL}/currencies');
      for (var j in response.data) {
        Currency.add(CurrencyModel.fromJson(j));
      }
      return Currency;
    } catch (e) {
      throw ServerException();
    }
  }
}
