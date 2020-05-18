import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sss_mobile/apis/vehicle_api.dart';
import 'package:sss_mobile/blocs/trip/trip_bloc.dart';
import 'package:sss_mobile/blocs/trip/trip_event.dart';
import 'package:sss_mobile/blocs/trip/trip_screen.dart';
import 'package:sss_mobile/blocs/vehicle_detail/vehicle_detail.dart';
import 'package:sss_mobile/models/maintenance.dart';
import 'package:sss_mobile/models/refueling.dart';
import 'package:sss_mobile/models/trip.dart';
import 'package:sss_mobile/models/vehicle.dart';
import 'package:sss_mobile/repositories/vehicle_repo.dart';

class VehicleDetailPage extends StatelessWidget {
  Trip lastTripWithLocation(Vehicle vehicle) {
    if (vehicle.trips != null) {
      for (Trip trip in vehicle.trips) {
        if (trip.latitude != null && trip.longitude != null) {
          return trip;
        }
      }
    }

    return null;
  }

  LatLng lastTripPosition(Vehicle vehicle) {
    Trip trip = lastTripWithLocation(vehicle);
    if (trip != null) {
      print("Found position");
      return LatLng(trip.latitude, trip.longitude);
    }
    print("Using suma position");
    return _kSUMAPos;
  }

  static final LatLng _kSUMAPos = LatLng(50.041553, 14.443436);

  Widget _buildRowForTrip(BuildContext context, Trip trip, Vehicle vehicle) {
    return new ListTile(
      title: new Text("${trip.beginOdometer} - ${trip.endOdometer}"),
      subtitle: new Text("${trip.id} - date: ${trip.endDate}"),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider(
                create: (context) =>
                TripBloc(vehicleRepository: VehicleRepository(vehicleAPI: VehicleAPI()))
                  ..add(ShowTrip(trip, vehicle)),
                child: TripPage());
          },
        ));
      },
    );
  }

  Widget _buildRowForMaintenance(Maintenance maintenance) {
    return new ListTile(
      subtitle: new Text("${maintenance.user.name}"),
      title: new Text("${maintenance.state} - ${maintenance.note}"),
    );
  }

  Widget _buildRowForRefueling(Refueling refueling) {
    return new ListTile(
      subtitle: new Text("${refueling.user.name}"),
      title: new Text("${refueling.odometer} km - ${refueling.fuelAmount} litres"),
      onTap: () {},
    );
  }

  Widget buildTrips(BuildContext context, VehicleDetailState state) {
    if (state is VehicleDetailFullyLoaded) {
      if (state.vehicle.trips.length == 0) {
        return Center(child: Text('Vozidlo nemá žádné výjezdy'));
      }
      return new ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: state.vehicle.trips.length,
          itemBuilder: (BuildContext context, int position) {
            return _buildRowForTrip(context, state.vehicle.trips[position], state.vehicle);
          });
    }
    return Container();
  }

  Widget buildRefuelings(BuildContext context, VehicleDetailState state) {
    if (state is VehicleDetailFullyLoaded) {
      if (state.vehicle.refueling.length == 0) {
        return Center(child: Text('Vozidlo nemá žádné záznamy tankování'));
      }
      return new ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: state.vehicle.refueling.length,
          itemBuilder: (BuildContext context, int position) {
            return _buildRowForRefueling(state.vehicle.refueling[position]);
          });
    }
    return Container();
  }

  Widget buildMaintenances(BuildContext context, VehicleDetailState state) {
    if (state is VehicleDetailFullyLoaded) {
      if (state.vehicle.maintenance.length == 0) {
        return Center(child: Text('Vozidlo nemá žádné servisní záznamy'));
      }
      return new ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: state.vehicle.maintenance.length,
          itemBuilder: (BuildContext context, int position) {
            return _buildRowForMaintenance(state.vehicle.maintenance[position]);
          });
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.local_gas_station)),
              Tab(icon: Icon(Icons.build)),
              Tab(icon: Icon(Icons.map))
            ],
          ),
          title: BlocConsumer<VehicleDetailBloc, VehicleDetailState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is VehicleDetailStateWithVehicle) {
                  return Text(state.vehicle.name);
                }
                return Text('Vozidlo');
              }),
        ),
        body: BlocBuilder<VehicleDetailBloc, VehicleDetailState>(builder: (context, state) {
          if (state is VehicleDetailLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is VehicleDetailError) {
            return Center(child: Text(state.message));
          }

          if (state is VehicleDetailStateWithVehicle) {
            if (state is VehicleDetailLoaded) {
              BlocProvider.of<VehicleDetailBloc>(context).add(FullyLoadVehicle(vehicle: state.vehicle));
            }

            var _vehicle = state.vehicle;
            LatLng lastTripPos = lastTripPosition(_vehicle);
            Set<Marker> _markers = {};
            _markers.add(Marker(
              markerId: MarkerId('<MARKER_ID>'),
              position: lastTripPos,
            ));

            return TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Scaffold(
                    body: buildTrips(context, state),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: () {
                        var trip = Trip();
                        trip.beginOdometer = _vehicle.trips.first.endOdometer;
                        trip.endOdometer = _vehicle.trips.first.endOdometer;
                        trip.beginDate = DateTime.now();
                        trip.endDate = DateTime.now();
                        trip.officialTrip = true;


                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return BlocProvider(
                                create: (context) =>
                                TripBloc(vehicleRepository: VehicleRepository(vehicleAPI: VehicleAPI()))
                                  ..add(ShowTrip(trip, _vehicle)),
                                child: TripPage());
                          }, fullscreenDialog: true
                        ));
                      },
                      label: Text('Přidat Jízdu'),
                      icon: Icon(Icons.directions_car),
                    )),
                Scaffold(
                    body: buildRefuelings(context, state),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: () => print('Add Fueling'),
                      label: Text('Přidat Tankování'),
                      icon: Icon(Icons.local_gas_station),
                    )),
                Scaffold(
                  body: buildMaintenances(context, state),
                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: () => print('Add Service'),
                    label: Text('Přidat Servis'),
                    icon: Icon(Icons.build),
                  ),
                ),
                new Scaffold(
                  body: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(target: lastTripPos, zoom: 16),
                      markers: _markers),
                )
              ],
            );
          }

          return Container();
        }),
      ),
    );
  }
}
