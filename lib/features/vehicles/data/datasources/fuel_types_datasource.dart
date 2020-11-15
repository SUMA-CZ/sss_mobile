import 'package:dio/dio.dart';
import 'package:sss_mobile/features/vehicles/data/models/fuel_type_model.dart';

abstract class FuelTypesDataSource {
  Future<List<FuelTypeModel>> getAll();
}

class FuelTypesDataSourceImpl implements FuelTypesDataSource {
  final Dio client;

  FuelTypesDataSourceImpl({this.client});

  @override
  Future<List<FuelTypeModel>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
