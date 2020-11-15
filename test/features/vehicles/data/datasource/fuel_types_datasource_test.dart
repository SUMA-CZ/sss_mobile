import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/fuel_types_datasource.dart';
import 'package:sss_mobile/features/vehicles/data/models/fuel_type_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/dio_response_helper.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

void main() {
  final dio = Dio();
  FuelTypesDataSourceImpl dataSource;
  DioAdapterMock dioAdapterMock;

  setUp(() {
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    dataSource = FuelTypesDataSourceImpl(client: dio);
  });

  group('getVehicles', () {
    var tFuelTypes = <FuelTypeModel>[];
    for (var j in json.decode(fixture('fueltypes.json'))) {
      tFuelTypes.add(FuelTypeModel.fromJson(j));
    }

    test(
      'should return List<VatRateModel> when the response is 200',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 200, 'fueltypes.json');
        // act
        final result = await dataSource.getAll();
        // assert
        expect(result, equals(tFuelTypes));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setHTTPResponse(dioAdapterMock, 400, null);
        // act
        final call = dataSource.getAll;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
