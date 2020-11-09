import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/vehicle_detail_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/widgets/maintenance_list.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/widgets/refueling_list.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/widgets/trip_list.dart';

class VehicleDetailScreen extends StatelessWidget {
  @override
  Widget _buildTrips() {
    return BlocBuilder<VehicleDetailCubit, VehicleDetailState>(
      builder: (context, state) {
        if (state is VDSTripsLoaded) {
          return TripList(
            trips: state.trips,
          );
        }
        if (state is VDSTripsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Text('error');
      },
      buildWhen: (previous, current) =>
          (current is VDSTripsLoaded || current is VDSTripsLoading || current is VDSTripsError),
    );
  }

  Widget _buildRefueling() {
    return BlocBuilder<VehicleDetailCubit, VehicleDetailState>(
      builder: (context, state) {
        if (state is VDSRefuelingLoaded) {
          return RefuelingList(refuelings: state.refuelings);
        }

        if (state is VDSRefuelingsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Text('error');
      },
      buildWhen: (previous, current) => (current is VDSRefuelingLoaded ||
          current is VDSRefuelingsLoading ||
          current is VDSRefuelingsError),
    );
  }

  Widget _buildMaintenances() {
    return BlocBuilder<VehicleDetailCubit, VehicleDetailState>(
      builder: (context, state) {
        if (state is VDSMaintenancesLoaded) {
          return MaintenanceList(maintenances: state.maintenances);
        }

        if (state is VDSMaintenancesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Text('error');
      },
      buildWhen: (previous, current) => (current is VDSMaintenancesLoading ||
          current is VDSMaintenancesLoaded ||
          current is VDSMaintenancesError),
    );
  }

  Widget _buildMap() {
    return BlocBuilder<VehicleDetailCubit, VehicleDetailState>(
      builder: (context, state) {
        if (state is VehicleDetailInitial) {
          if (state.vehicle.latitude == null ||
              state.vehicle.latitude == 0 ||
              state.vehicle.longitude == null ||
              state.vehicle.longitude == 0) {
            return Center(
              child: Text('No location'),
            );
          }
          LatLng pinPosition = LatLng(state.vehicle.latitude, state.vehicle.longitude);
          CameraPosition initialLocation =
              CameraPosition(zoom: 16, bearing: 30, target: pinPosition);
          return GoogleMap(
              markers: [
                Marker(markerId: MarkerId('<MARKER_ID>'), position: pinPosition, visible: true)
              ].toSet(),
              initialCameraPosition: initialLocation);
        }
        return Text('err');
      },
      buildWhen: (previous, current) => current is VehicleDetailInitial,
    );
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Vehicle Detail'),
              bottom: TabBar(
                onTap: (index) {
                  if (index == 0) {
                    BlocProvider.of<VehicleDetailCubit>(context).getTrips();
                  }
                  if (index == 1) {
                    BlocProvider.of<VehicleDetailCubit>(context).getRefuelings();
                  }
                  if (index == 2) {
                    BlocProvider.of<VehicleDetailCubit>(context).getMaintenances();
                  }
                  if (index == 3) {
                    BlocProvider.of<VehicleDetailCubit>(context).getVehicle();
                  }
                },
                tabs: [
                  Tab(icon: Icon(Icons.directions_car_outlined)),
                  Tab(icon: Icon(Icons.local_gas_station_outlined)),
                  Tab(icon: Icon(Icons.build_circle_outlined)),
                  Tab(icon: Icon(Icons.map_outlined))
                ],
              ),
            ),
            body: TabBarView(
                children: [_buildTrips(), _buildRefueling(), _buildMaintenances(), _buildMap()])));
  }
}
