import 'package:dio/dio.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/features/vehicles/data/models/fuel_type_model.dart';

import '../../../../env_config.dart';

abstract class FuelTypesDataSource {
  Future<List<FuelTypeModel>> getAll();
}

class FuelTypesDataSourceImpl implements FuelTypesDataSource {
  final Dio client;

  FuelTypesDataSourceImpl({this.client});

  @override
  Future<List<FuelTypeModel>> getAll() async {
    try {
      var fuelTypes = <FuelTypeModel>[];
      final response = await client.get('${EnvConfig.API_URL}/fueltypes');
      for (var j in response.data) {
        fuelTypes.add(FuelTypeModel.fromJson(j));
      }
      return fuelTypes;
    } catch (e) {
      throw ServerException();
    }
  }
}
