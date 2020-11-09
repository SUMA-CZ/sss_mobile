// import 'dart:convert';
//
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:sss_mobile/core/error/failure.dart';
// import 'package:sss_mobile/features/vehicles/data/models/maintenance_model.dart';
// import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
// import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
// import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
// import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
// import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
// import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
// import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
// import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/vehicle_detail_cubit.dart';
//
// import '../../../../../fixtures/fixture_reader.dart';
//
// class MockVehicleRepository extends Mock implements VehicleRepository {}
//
// void main() {
//   VehicleDetailCubit cubit;
//   MockVehicleRepository mockVehicleRepository;
//   Vehicle vehicle;
//
//   setUp(() {
//     vehicle = Vehicle(id: 27, spz: 'AAAA');
//     mockVehicleRepository = MockVehicleRepository();
//     cubit = VehicleDetailCubit(vehicleRepository: mockVehicleRepository, vehicle: vehicle);
//   });
//
//   var tTrips = <Trip>[];
//   for (var j in json.decode(fixture('trips.json'))) {
//     tTrips.add(TripModel.fromJson(j));
//   }
//
//   var tRefuelings = <Refueling>[];
//   for (var j in json.decode(fixture('refuelings.json'))) {
//     tRefuelings.add(RefuelingModel.fromJson(j));
//   }
//
//   var tMaintenances = <Maintenance>[];
//   for (var j in json.decode(fixture('maintenances.json'))) {
//     tMaintenances.add(MaintenanceModel.fromJson(j));
//   }
//
//   // group('getTrips', () {
//   //   final successEither = tTrips;
//   //   test(
//   //     'should get get trips from repository',
//   //     () async {
//   //       // arrange
//   //       when(mockVehicleRepository.getTripsForVehicleID(vehicle.id))
//   //           .thenAnswer((realInvocation) async => Right(successEither));
//   //       // act
//   //       cubit.getTrips();
//   //       // assert
//   //       verify(mockVehicleRepository.getTripsForVehicleID(vehicle.id));
//   //     },
//   //   );
//   //
//   //   test(
//   //     'should [Loading, ShowTrips] when success on trips',
//   //     () async {
//   //       // arrange
//   //       when(mockVehicleRepository.getTripsForVehicleID(vehicle.id))
//   //           .thenAnswer((realInvocation) async => Right(successEither));
//   //       // act
//   //       final expected = [VDSTripsLoading(), VDSTripsLoaded(successEither)];
//   //
//   //       // assert
//   //       expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2));
//   //
//   //       // act
//   //       cubit.getTrips();
//   //     },
//   //   );
//   //
//   //   test(
//   //     'should [Loading, Error] when trips fail',
//   //     () async {
//   //       // arrange
//   //       when(mockVehicleRepository.getTripsForVehicleID(vehicle.id))
//   //           .thenAnswer((realInvocation) async => Left(ServerFailure()));
//   //       // act
//   //
//   //       final expected = [VDSTripsLoading(), VDSTripsError()];
//   //
//   //       // assert
//   //       expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2));
//   //
//   //       // act
//   //       cubit.getTrips();
//   //     },
//   //   );
//   // });
//
//   group('getRefuelings', () {
//     final successEither = tRefuelings;
//     test(
//       'should get get refuelings from repository',
//       () async {
//         // arrange
//         when(mockVehicleRepository.getRefuelingsForVehicleID(vehicle.id))
//             .thenAnswer((realInvocation) async => Right(successEither));
//         // act
//         cubit.getRefuelings();
//         // assert
//         verify(mockVehicleRepository.getRefuelingsForVehicleID(vehicle.id));
//       },
//     );
//
//     test(
//       'should [Loading, ShowTrips] when success on refuelings',
//       () async {
//         // arrange
//         when(mockVehicleRepository.getRefuelingsForVehicleID(vehicle.id))
//             .thenAnswer((realInvocation) async => Right(successEither));
//         // act
//         final expected = [VDSRefuelingsLoading(), VDSRefuelingLoaded(successEither)];
//
//         // assert
//         expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2));
//
//         // act
//         cubit.getRefuelings();
//       },
//     );
//
//     test(
//       'should [Loading, Error] when refuelings fail',
//       () async {
//         // arrange
//         when(mockVehicleRepository.getRefuelingsForVehicleID(vehicle.id))
//             .thenAnswer((realInvocation) async => Left(ServerFailure()));
//         // act
//
//         final expected = [VDSRefuelingsLoading(), VDSRefuelingsError()];
//
//         // assert
//         expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2));
//
//         // act
//         cubit.getRefuelings();
//       },
//     );
//   });
//
//   group('getMaintenaces', () {
//     final successEither = tMaintenances;
//     test(
//       'should get get maintenances from repository',
//       () async {
//         // arrange
//         when(mockVehicleRepository.getMaintenancesForVehicleID(vehicle.id))
//             .thenAnswer((realInvocation) async => Right(successEither));
//         // act
//         cubit.getMaintenances();
//         // assert
//         verify(mockVehicleRepository.getMaintenancesForVehicleID(vehicle.id));
//       },
//     );
//
//     test(
//       'should [Loading, ShowTrips] when success on maintenances',
//       () async {
//         // arrange
//         when(mockVehicleRepository.getMaintenancesForVehicleID(vehicle.id))
//             .thenAnswer((realInvocation) async => Right(successEither));
//         // act
//         final expected = [VDSMaintenancesLoading(), VDSMaintenancesLoaded(successEither)];
//
//         // assert
//         expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2));
//
//         // act
//         cubit.getMaintenances();
//       },
//     );
//
//     test(
//       'should [Loading, Error] when maintenances fail',
//       () async {
//         // arrange
//         when(mockVehicleRepository.getMaintenancesForVehicleID(vehicle.id))
//             .thenAnswer((realInvocation) async => Left(ServerFailure()));
//         // act
//
//         final expected = [VDSMaintenancesLoading(), VDSMaintenancesError()];
//
//         // assert
//         expectLater(cubit, emitsInOrder(expected)).timeout(Duration(seconds: 2));
//
//         // act
//         cubit.getMaintenances();
//       },
//     );
//   });
// }
