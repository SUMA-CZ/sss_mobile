// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:sss_mobile/clean_architecture/features/vehicles/domain/repositories/vehicle_repository.dart';
//
// import 'vehicle_list.dart';
//
// class VehicleListBloc extends Bloc<VehicleListEvent, VehicleListState> {
//   final VehicleRepository vehicleRepository;
//
//   VehicleListBloc({@required this.vehicleRepository})
//       : assert(vehicleRepository != null),
//         super(VehicleListEmpty());
//
//   @override
//   Stream<VehicleListState> mapEventToState(VehicleListEvent event) async* {
//     if (event is FetchVehiclesList) {
//       yield VehicleListLoading();
//       try {
//         // final List<Vehicle> vehicles = await vehicleRepository.updateVehicles();
//         // yield VehicleListLoaded(vehicles: vehicles);
//       } catch (_) {
//         yield VehicleListError();
//       }
//     }
//
//     if (event is TestVehicleList) {
//       yield VehicleListLoading();
//       try {
//         await Future.delayed(Duration(seconds: 2));
//         yield VehicleListLoaded(vehicles: []);
//       } catch (_) {
//         yield VehicleListError();
//       }
//     }
//   }
// }
