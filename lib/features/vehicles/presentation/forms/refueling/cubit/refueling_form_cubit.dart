import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/fuel_type.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vat_rate.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_fuel_types.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_vat_rates.dart';

part 'refueling_form_state.dart';

class RefuelingFormCubit extends Cubit<RefuelingFormState> {
  RefuelingFormCubit({
    @required this.getRefueling,
    @required this.vehicle,
    @required this.readVatRates,
    @required this.readFuelTypes,
  })  : assert(getRefueling != null, vehicle != null),
        super(RefuelingFormStateInitial());

  final CreateRefueling getRefueling;
  final ReadVatRates readVatRates;
  final ReadFuelTypes readFuelTypes;
  final Vehicle vehicle;

  void createRefueling(Refueling refueling) async {
    emit(RefuelingFormStateLoading());
    emit((await getRefueling(Params(vehicleID: vehicle.id, refueling: refueling))).fold(
      (failure) => RefuelingFormStateError(),
      (payload) => RefuelingFormStateCreated(),
    ));
  }

  void getLoaded() async {
    emit(RefuelingFormStateLoading());

    var vatRates;
    var fueltypes;

    emit((await readVatRates(NoParamsReadVat())).fold(
      (failure) {
        return RefuelingFormStateError();
      },
      (payload) {
        vatRates = payload;
        return RefuelingFormStateLoading();
      },
    ));

    emit((await readFuelTypes(NoParams())).fold(
      (failure) => RefuelingFormStateError(),
      (payload) {
        fueltypes = payload;
        return RefuelingFormStateLoading();
      },
    ));

    emit(RefuelingFormStateLoaded(fuelTypes: fueltypes, vatRates: vatRates));
  }
}
