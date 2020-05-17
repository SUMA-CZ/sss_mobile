import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sss_mobile/blocs/vehicle_detail/vehicle_detail.dart';
import 'package:sss_mobile/models/maintenance.dart';
import 'package:sss_mobile/models/refueling.dart';
import 'package:sss_mobile/models/trip.dart';
import 'package:sss_mobile/models/vehicle.dart';
import 'package:sss_mobile/screens/trip_screen.dart';

class VehicleDetailScreen extends StatefulWidget {
  VehicleDetailScreen();

  @override
  createState() => new VehicleDetailScreenState();
}

class VehicleDetailScreenState extends State<VehicleDetailScreen> {
  RefreshController _refreshTrips = RefreshController(initialRefresh: true);
  RefreshController _refreshMaintenance = RefreshController(initialRefresh: true);
  RefreshController _refreshRefuelings = RefreshController(initialRefresh: true);

  VehicleDetailScreenState();

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};

  static final LatLng center = const LatLng(50.041553, 14.443436);

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

  static final CameraPosition _kSUMACameraPos = CameraPosition(
    target: _kSUMAPos,
    zoom: 17,
  );

  @override
  void initState() {
    super.initState();
    _refreshMaintenance.refreshToIdle();
    _refreshRefuelings.refreshToIdle();
    _refreshTrips.refreshToIdle();
  }

  Widget _buildRowForTrip(Trip trip, Vehicle vehicle) {
    return new ListTile(
      title: new Text("${trip.beginOdometer} - ${trip.endOdometer}"),
      subtitle: new Text("${trip.id} - date: ${trip.endDate}"),
      onTap: () {
        print('object');
        Navigator.push(context, MaterialPageRoute(builder: (context) => TripScreen(trip, vehicle)));
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [Tab(icon: Icon(Icons.directions_car)), Tab(icon: Icon(Icons.local_gas_station)), Tab(icon: Icon(Icons.build)), Tab(icon: Icon(Icons.map))],
          ),
          title: Text('vehicle.name'),
        ),
        body: BlocBuilder<VehicleDetailBloc, VehicleDetailState>(builder: (context, state) {
          if (state is VehicleDetailLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is VehicleDetailError) {
            return Center(child: Text('Nastala chyba'));
          }

          if (state is VehicleDetailLoaded) {
            var _vehicle = state.vehicle;
            var _trips = state.vehicle.trips;
            var _refuelings = state.vehicle.refueling;
            var _maintenances = state.vehicle.maintenance;

            return TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Scaffold(
                    body: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: WaterDropHeader(),
                      controller: _refreshTrips,
//                  onRefresh: BlocProvider.of<VehicleListBloc>(context).add(FetchVehiclesList()),
                      child: new ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: _trips.length,
                          itemBuilder: (BuildContext context, int position) {
                            return _buildRowForTrip(_trips[position], _vehicle);
                          }),
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TripScreen(Trip(), _vehicle)));
                      },
                      label: Text('Přidat Jízdu'),
                      icon: Icon(Icons.directions_car),
                    )),
                Scaffold(
                    body: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: WaterDropHeader(),
                      controller: _refreshRefuelings,
//                  onRefresh: _loadData,
                      child: new ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: _refuelings.length,
                          itemBuilder: (BuildContext context, int position) {
                            return _buildRowForRefueling(_refuelings[position]);
                          }),
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: () => print('Add Fueling'),
                      label: Text('Přidat Tankování'),
                      icon: Icon(Icons.local_gas_station),
                    )),
                Scaffold(
                  body: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropHeader(),
                    controller: _refreshMaintenance,
//                onRefresh: _loadData,
                    child: new ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: _maintenances.length,
                        itemBuilder: (BuildContext context, int position) {
                          return _buildRowForMaintenance(_maintenances[position]);
                        }),
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: () => print('Add Service'),
                    label: Text('Přidat Servis'),
                    icon: Icon(Icons.build),
                  ),
                ),
                new Scaffold(
                  body: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: _kSUMACameraPos,
                      onMapCreated: (GoogleMapController controller) {
                        if (!_controller.isCompleted) {
                          _controller.complete(controller);
                        }

                        LatLng lastTripPos = lastTripPosition(_vehicle);

                        setState(() {
                          _markers.add(Marker(
                            markerId: MarkerId('<MARKER_ID>'),
                            position: lastTripPos,
                          ));
                        });

                        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: lastTripPos, zoom: 16)));
                      },
                      markers: _markers),
                )
              ],
            );
          }

          return null;
        }),
      ),
    );
  }
}
