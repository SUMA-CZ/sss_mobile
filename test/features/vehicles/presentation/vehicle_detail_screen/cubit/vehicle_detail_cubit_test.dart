import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/vehicle_detail_cubit.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  VehicleDetailCubit cubit;
  MockVehicleRepository mockVehicleRepository;
  Vehicle vehicle;

  setUp(() {
    vehicle = Vehicle(id: 27, spz: 'AAAA');
    mockVehicleRepository = MockVehicleRepository();
    cubit = VehicleDetailCubit(vehicleRepository: mockVehicleRepository, vehicle: vehicle);
  });

  test(
    'should be intitial with vehicle',
    () async {
      expect(cubit.state, VehicleDetailInitial(vehicle: vehicle));
    },
  );
}
