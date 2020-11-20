import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sss_mobile/core/error/failure.dart';
import 'package:sss_mobile/features/vehicles/data/models/currency_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/fuel_type_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model_create_dto.dart';
import 'package:sss_mobile/features/vehicles/data/models/vat_rate_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/currency.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/fuel_type.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vat_rate.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_currencies.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_fuel_types.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_vat_rates.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/refueling/cubit/refueling_form_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/refuelings/refuelings_cubit.dart';

import '../../../../../../fixtures/fixture_reader.dart';

class MockCreateRefueling extends Mock implements CreateRefueling {}

class MockReadVatRates extends Mock implements ReadVatRates {}

class MockReadFuelTypes extends Mock implements ReadFuelTypes {}

class MockReadCurrency extends Mock implements ReadCurrency {}

class MockRefuelingCubit extends Mock implements RefuelingsCubit {}

void main() {
  RefuelingFormCubit cubit;
  MockCreateRefueling mockCreateRefueling;
  Vehicle vehicle;
  MockReadVatRates mockReadVatRates;
  MockReadFuelTypes mockReadFuelTypes;
  MockReadCurrency mockReadCurrency;
  MockRefuelingCubit mockRefuelingCubit;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockCreateRefueling = MockCreateRefueling();
    mockReadVatRates = MockReadVatRates();
    mockReadFuelTypes = MockReadFuelTypes();
    mockReadCurrency = MockReadCurrency();
    mockRefuelingCubit = MockRefuelingCubit();

    cubit = RefuelingFormCubit(
        createRefuelingUseCase: mockCreateRefueling,
        vehicle: vehicle,
        readVatRates: mockReadVatRates,
        readFuelTypes: mockReadFuelTypes,
        readCurrency: mockReadCurrency,
        refuelingsCubit: mockRefuelingCubit);
  });

  final returnModel = RefuelingModel.fromJson(jsonDecode(fixture('refueling.json')));

  final createRefuelingDTO = RefuelingModelCreateDTO()..base64Image = 'fekal';

  var currencies = <Currency>[];
  for (var j in jsonDecode(fixture('currencies.json'))) {
    currencies.add(CurrencyModel.fromJson(j));
  }

  var fuelTypes = <FuelType>[];
  for (var j in jsonDecode(fixture('fueltypes.json'))) {
    fuelTypes.add(FuelTypeModel.fromJson(j));
  }

  var vatrates = <VatRate>[];
  for (var j in jsonDecode(fixture('vatrates.json'))) {
    vatrates.add(VatRateModel.fromJson(j));
  }

  group('createRefueling', () {
    test(
      'should use Usecase to get data',
      () async {
        // arrange
        when(mockCreateRefueling.call(Params(vehicleID: vehicle.id, refueling: createRefuelingDTO)))
            .thenAnswer((realInvocation) async => Right(returnModel));
        // act
        await cubit.createRefueling(createRefuelingDTO);
        // assert
        verify(
            mockCreateRefueling.call(Params(vehicleID: vehicle.id, refueling: createRefuelingDTO)));

        verifyNoMoreInteractions(mockReadCurrency);
        verifyNoMoreInteractions(mockReadFuelTypes);
        verifyNoMoreInteractions(mockReadVatRates);
        verifyNoMoreInteractions(mockCreateRefueling);
      },
    );

    test(
      'should use [Loading, Created] when 200',
      () async {
        // arrange
        when(mockCreateRefueling.call(Params(vehicleID: vehicle.id, refueling: createRefuelingDTO)))
            .thenAnswer((realInvocation) async => Right(returnModel));
        // act
        await cubit.createRefueling(createRefuelingDTO);
        // assert
        verify(
            mockCreateRefueling.call(Params(vehicleID: vehicle.id, refueling: createRefuelingDTO)));
        verify(mockRefuelingCubit.read());
        verifyNoMoreInteractions(mockReadCurrency);
        verifyNoMoreInteractions(mockReadFuelTypes);
        verifyNoMoreInteractions(mockReadVatRates);
        verifyNoMoreInteractions(mockCreateRefueling);

        final expected = [RefuelingFormStateLoading(), RefuelingFormStateCreated()];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.createRefueling(createRefuelingDTO);
      },
    );

    test(
      'should use [Loading, Error] when 200',
      () async {
        // arrange
        when(mockCreateRefueling.call(Params(vehicleID: vehicle.id, refueling: createRefuelingDTO)))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // act
        await cubit.createRefueling(createRefuelingDTO);
        // assert
        verify(
            mockCreateRefueling.call(Params(vehicleID: vehicle.id, refueling: createRefuelingDTO)));
        verifyNoMoreInteractions(mockReadCurrency);
        verifyNoMoreInteractions(mockReadFuelTypes);
        verifyNoMoreInteractions(mockReadVatRates);
        verifyNoMoreInteractions(mockCreateRefueling);

        final expected = [RefuelingFormStateLoading(), RefuelingFormStateError()];

        // assert
        unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

        // act
        cubit.createRefueling(createRefuelingDTO);
      },
    );
  });

  group('getLoaded', () {
    test('should [Loading, Loaded] when getting vatrates, flueltypes and currencies was success',
        () async {
      when(mockReadCurrency.call(any)).thenAnswer((realInvocation) async => Right(currencies));
      when(mockReadFuelTypes.call(any)).thenAnswer((realInvocation) async => Right(fuelTypes));
      when(mockReadVatRates.call(any)).thenAnswer((realInvocation) async => Right(vatrates));

      final expected = [
        RefuelingFormStateLoading(),
        RefuelingFormStateLoaded(fuelTypes: fuelTypes, vatRates: vatrates, currencies: currencies)
      ];

      unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));

      await cubit.getLoaded();
    });

    test('should [Loading, Error] when currecies fail to fetch', () async {
      when(mockReadCurrency.call(any)).thenAnswer((realInvocation) async => Left(ServerFailure()));
      when(mockReadFuelTypes.call(any)).thenAnswer((realInvocation) async => Right(fuelTypes));
      when(mockReadVatRates.call(any)).thenAnswer((realInvocation) async => Right(vatrates));

      final expected = [RefuelingFormStateLoading(), RefuelingFormStateError()];

      unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));
      await cubit.getLoaded();
    });

    test('should [Loading, Error] when fueltypes fail to fetch', () async {
      when(mockReadCurrency.call(any)).thenAnswer((realInvocation) async => Right(currencies));
      when(mockReadFuelTypes.call(any)).thenAnswer((realInvocation) async => Left(ServerFailure()));
      when(mockReadVatRates.call(any)).thenAnswer((realInvocation) async => Right(vatrates));

      final expected = [RefuelingFormStateLoading(), RefuelingFormStateError()];

      unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));
      await cubit.getLoaded();
    });

    test('should [Loading, Error] when vat rates fail to fetch', () async {
      when(mockReadCurrency.call(any)).thenAnswer((realInvocation) async => Right(currencies));
      when(mockReadFuelTypes.call(any)).thenAnswer((realInvocation) async => Right(fuelTypes));
      when(mockReadVatRates.call(any)).thenAnswer((realInvocation) async => Left(ServerFailure()));

      final expected = [RefuelingFormStateLoading(), RefuelingFormStateError()];

      unawaited(expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2)));
      await cubit.getLoaded();
    });
  });
}
