import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model_create_dto.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/currency.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/fuel_type.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vat_rate.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_currencies.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_fuel_types.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_vat_rates.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/refuelings/refuelings_cubit.dart';

part 'refueling_form_state.dart';

class RefuelingFormCubit extends Cubit<RefuelingFormState> {
  RefuelingFormCubit(
      {@required this.createRefuelingUseCase,
      @required this.vehicle,
      @required this.readVatRates,
      @required this.readFuelTypes,
      @required this.readCurrency,
      @required this.refuelingsCubit})
      : assert(
            createRefuelingUseCase != null &&
                vehicle != null &&
                readVatRates != null &&
                readFuelTypes != null &&
                readCurrency != null,
            refuelingsCubit != null),
        super(RefuelingFormStateInitial());

  final CreateRefueling createRefuelingUseCase;
  final ReadVatRates readVatRates;
  final ReadFuelTypes readFuelTypes;
  final ReadCurrency readCurrency;
  final Vehicle vehicle;

  final RefuelingsCubit refuelingsCubit;

  void createRefueling(Refueling refueling) async {
    emit(RefuelingFormStateLoading());
    emit((await createRefuelingUseCase(Params(vehicleID: vehicle.id, refueling: refueling))).fold(
      (failure) => RefuelingFormStateError(),
      (payload) => RefuelingFormStateCreated(),
    ));
    await refuelingsCubit.read();
  }

  void createRefuelingWithFormData(Map<String, dynamic> data) async {
    emit(RefuelingFormStateLoading());

    try {
      var model = RefuelingModelCreateDTO();
      model.date = data['Date'];
      model.odometer = int.parse(data['OdometerState']);
      model.price = double.parse(data['PriceIncludingVAT'].toString().replaceAll(',', '.'));
      model.official = data['OfficialJourney'];
      model.note = data['Note'];
      model.fuelAmount = double.parse(data['FuelBulk'].toString().replaceAll(',', '.'));
      model.currencyObject = data['Currency'];
      model.vatRateObject = data['VatRate'];
      model.fuelTypeObject = data['FuelType'];
      model.receiptNo = data['ReceiptNumber'];

      if ((data['images'] as List<dynamic>).isNotEmpty) {
        File file = data['images'].first;
        final bytes = await Io.File(file.path).readAsBytes();
        final base = base64Encode(bytes);
        model.base64Image = base;
      }

      createRefueling(model);
    } catch (e) {
      emit(RefuelingFormStateError());
      // await getLoaded();
    }
  }

  void getLoaded() async {
    emit(RefuelingFormStateLoading());

    var vatRates;
    var fuelTypes;
    var currencies;

    (await readVatRates(NoParamsReadVat())).fold(
      (failure) => emit(RefuelingFormStateError()),
      (payload) => vatRates = payload,
    );

    (await readFuelTypes(NoParams())).fold(
      (failure) => emit(RefuelingFormStateError()),
      (payload) => fuelTypes = payload,
    );

    (await readCurrency(NoParamsCurrency())).fold(
      (failure) => emit(RefuelingFormStateError()),
      (payload) => currencies = payload,
    );

    if (vatRates != null && currencies != null && fuelTypes != null) {
      emit(RefuelingFormStateLoaded(
          fuelTypes: fuelTypes, vatRates: vatRates, currencies: currencies));
    }
  }
}
