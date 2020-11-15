import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/widgets/loading_indicator.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/maintenances/maintenances_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/refuelings/refuelings_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/trips/trips_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/vehicle_detail_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/widgets/maintenance_list.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/widgets/refueling_list.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/widgets/trip_list.dart';

import '../../../../injection_container.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Vehicle vehicle;

  VehicleDetailScreen({@required this.vehicle}) : assert(vehicle != null);

  Widget _buildTrips() {
    return BlocProvider<TripsCubit>(
      create: (context) => sl<TripsCubit>(param1: vehicle)..getTrips(),
      child: BlocBuilder<TripsCubit, TripsState>(
        buildWhen: (previous, current) =>
            (current is! MaintenancesStateDeleted && current is! MaintenancesStateErrorDeleting),
        builder: (context, state) {
          if (state is TripsStateLoaded) {
            return TripList(
              trips: state.trips,
              vehicle: vehicle,
            );
          }

          if (state is TripsStateLoading) {
            return LoadingIndicator();
          }

          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(S.current.errorCom),
                  RaisedButton(
                      child: Text(S.current.refresh),
                      onPressed: () => BlocProvider.of<TripsCubit>(context).getTrips())
                ]),
          );
        },
      ),
    );
  }

  Widget _buildRefueling() {
    return BlocProvider<RefuelingsCubit>(
      create: (context) => sl<RefuelingsCubit>(param1: vehicle)..read(),
      child: BlocBuilder<RefuelingsCubit, RefuelingsState>(
        buildWhen: (previous, current) =>
            (current is! RefuelingsStateErrorDeleting && current is! RefuelingsStateDeleted),
        builder: (context, state) {
          if (state is RefuelingsStateLoaded) {
            return RefuelingList(refuelings: state.refuelings);
          }

          if (state is RefuelingsStateLoading) {
            return LoadingIndicator();
          }

          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(S.current.errorCom),
                  RaisedButton(
                      child: Text(S.current.refresh),
                      onPressed: () => BlocProvider.of<RefuelingsCubit>(context).read())
                ]),
          );
        },
      ),
    );
  }

  Widget _buildMaintenances() {
    return BlocProvider<MaintenancesCubit>(
      create: (context) => sl<MaintenancesCubit>(param1: vehicle)..read(),
      child: BlocBuilder<MaintenancesCubit, MaintenancesState>(
        buildWhen: (previous, current) =>
            (current is! TripsStateDeleted && current is! TripsStateErrorDeleting),
        builder: (context, state) {
          if (state is MaintenancesStateLoaded) {
            return MaintenanceList(maintenances: state.maintenances);
          }

          if (state is MaintenancesStateLoading) {
            return LoadingIndicator();
          }

          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(S.current.errorCom),
                  RaisedButton(
                      child: Text(S.current.refresh),
                      onPressed: () => BlocProvider.of<MaintenancesCubit>(context).read())
                ]),
          );
        },
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    return BlocBuilder<VehicleDetailCubit, VehicleDetailState>(builder: (context, state) {
      if (state is VehicleDetailStateInitial) {
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
                    cubit.readVehicle();
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
