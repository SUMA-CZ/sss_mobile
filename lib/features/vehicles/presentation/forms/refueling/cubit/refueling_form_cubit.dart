import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_refueling.dart';

part 'refueling_form_state.dart';

class RefuelingFormCubit extends Cubit<RefuelingFormState> {
  RefuelingFormCubit({@required this.usecase, @required this.vehicle})
      : assert(usecase != null, vehicle != null),
        super(RefuelingFormInitial());

  final CreateRefueling usecase;
  final Vehicle vehicle;

  void createTrip(Refueling refueling) async {
    emit(RefuelingFormLoading());
    emit((await usecase(Params(vehicleID: vehicle.id, refueling: refueling))).fold(
      (failure) => RefuelingFormError(),
      (payload) => RefuelingFormCreated(),
    ));
  }
}
