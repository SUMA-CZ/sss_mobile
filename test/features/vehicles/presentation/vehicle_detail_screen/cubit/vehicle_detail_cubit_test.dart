import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/vehicle_detail_cubit.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

class MockGetVehicle extends Mock implements GetVehicle {}

void main() {
  VehicleDetailCubit cubit;
  MockVehicleRepository mockVehicleRepository;
  Vehicle vehicle;
  MockGetVehicle mockGetVehicle;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockVehicleRepository = MockVehicleRepository();
    mockGetVehicle = MockGetVehicle();
    cubit = VehicleDetailCubit(
        vehicleRepository: mockVehicleRepository, vehicle: vehicle, usecase: mockGetVehicle);
  });

  test(
    'should be intitial with vehicle',
    () async {
      expect(cubit.state, VehicleDetailInitial(vehicle: vehicle));
    },
  );

  //TODO: add test
}
