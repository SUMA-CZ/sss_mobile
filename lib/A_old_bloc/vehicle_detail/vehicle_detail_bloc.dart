// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:sss_mobile/blocs/vehicle_detail/vehicle_detail.dart';
// import 'package:sss_mobile/clean_architecture/features/vehicles/domain/repositories/vehicle_repository.dart';
//
// class VehicleDetailBloc extends Bloc<VehicleDetailEvent, VehicleDetailState> {
//   final VehicleRepository vehicleRepository;
//
//   VehicleDetailBloc({@required this.vehicleRepository})
//       : assert(vehicleRepository != null),
//         super(VehicleDetailLoading());
//
//   @override
//   Stream<VehicleDetailState> mapEventToState(VehicleDetailEvent event) async* {
//     if (event is ShowVehicle) {
//       yield VehicleDetailLoading();
//       try {
//         yield VehicleDetailLoaded(vehicle: event.vehicle);
//       } catch (e) {
//         yield VehicleDetailError(message: e.toString());
//       }
//     }
//
//     if (event is FullyLoadVehicle) {
//       yield VehicleDetailFullyLoading();
//       try {
//         // final Vehicle vehicle = await vehicleRepository.fetchFullVehicle(event.vehicle);
//         // yield VehicleDetailFullyLoaded(vehicle: vehicle);
//       } catch (e) {
//         yield VehicleDetailError(message: e.toString());
//       }
//     }
//   }
// }
