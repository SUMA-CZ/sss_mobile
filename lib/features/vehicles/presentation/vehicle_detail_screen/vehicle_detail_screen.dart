import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/widgets/loading_indicator.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_maintenances_for_vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/get_refuelings_for_vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/maintenances/vehicle_detail_maintenances_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/refuelings/vehicle_detail_refuelings_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/trips/vehicle_detail_trips_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/vehicle_detail_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/widgets/maintenance_list.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/widgets/refueling_list.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/widgets/trip_list.dart';

import '../../../../injection_container.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Vehicle vehicle;

  VehicleDetailScreen({@required this.vehicle}) : assert(vehicle != null);

  Widget _buildTrips() {
    return BlocProvider<VehicleDetailTripsCubit>(
      create: (context) => sl<VehicleDetailTripsCubit>(param1: vehicle)..getTrips(),
      child: BlocBuilder<VehicleDetailTripsCubit, VehicleDetailTripsState>(
        buildWhen: (previous, current) => current != null,
        builder: (context, state) {
          if (state is VehicleDetailTripsLoaded) {
            return TripList(
              trips: state.trips,
              vehicle: vehicle,
            );
          }

          if (state is VehicleDetailTripsLoading) {
            return LoadingIndicator();
          }

          return Text('error');
        },
      ),
    );
  }

  Widget _buildRefueling() {
    return BlocProvider<VehicleDetailRefuelingsCubit>(
      create: (context) =>
          VehicleDetailRefuelingsCubit(usecase: sl<GetRefuelingsForVehicle>(), vehicle: vehicle)
            ..getRefuelings(),
      child: BlocBuilder<VehicleDetailRefuelingsCubit, VehicleDetailRefuelingsState>(
        builder: (context, state) {
          if (state is VehicleDetailRefuelingsLoaded) {
            return RefuelingList(refuelings: state.refuelings);
          }

          if (state is VehicleDetailRefuelingsLoading) {
            return LoadingIndicator();
          }

          return Text('error');
        },
      ),
    );
  }

  Widget _buildMaintenances() {
    return BlocProvider<VehicleDetailMaintenancesCubit>(
      create: (context) =>
          VehicleDetailMaintenancesCubit(usecase: sl<GetMaintenancesForVehicle>(), vehicle: vehicle)
            ..getMaintenances(),
      child: BlocBuilder<VehicleDetailMaintenancesCubit, VehicleDetailMaintenancesState>(
        builder: (context, state) {
          if (state is VehicleDetailMaintenancesLoaded) {
            return MaintenanceList(maintenances: state.maintenances);
          }

          if (state is VehicleDetailMaintenancesLoading) {
            return LoadingIndicator();
          }

          return Text('error');
        },
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    return BlocBuilder<VehicleDetailCubit, VehicleDetailState>(builder: (context, state) {
      if (state is VehicleDetailInitial) {
        if (state.vehicle.latitude == null ||
            state.vehicle.latitude == 0 ||
            state.vehicle.longitude == null ||
            state.vehicle.longitude == 0) {
          return Center(
            child: Text(S.current.vehicleDetailNoLocation),
          );
        }
        var pinPosition = LatLng(state.vehicle.latitude, state.vehicle.longitude);
        var initialLocation = CameraPosition(zoom: 16, bearing: 30, target: pinPosition);
        return GoogleMap(
          markers: {
            Marker(
              markerId: MarkerId('<MARKER_ID>'),
              position: pinPosition,
              visible: true,
            )
          },
          initialCameraPosition: initialLocation,
          gestureRecognizers: {(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))},
        );
      }
      return Text('err');
    });
  }

  @override
  Widget build(BuildContext context) {
    // return _buildTrips();
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              title: Text(vehicle.vin.trim().toUpperCase()),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car_outlined)),
                  Tab(icon: Icon(Icons.local_gas_station_outlined)),
                  Tab(icon: Icon(Icons.build_circle_outlined)),
                  Tab(icon: Icon(Icons.map_outlined))
                ],
                onTap: (index) {
                  if (index == 3) {
                    final cubit = BlocProvider.of<VehicleDetailCubit>(context);
                    cubit.getVehicle();
                  }
                },
              ),
            ),
            body: TabBarView(children: [
              _buildTrips(),
              _buildRefueling(),
              _buildMaintenances(),
              _buildMap(context)
            ])));
  }
}
