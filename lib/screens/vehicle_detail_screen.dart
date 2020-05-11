import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sss_mobile/models/maintenance.dart';
import 'package:sss_mobile/models/refueling.dart';
import 'package:sss_mobile/models/trip.dart';
import 'package:sss_mobile/models/vehicle.dart';
import 'package:sss_mobile/networking/vehicle_factory.dart';
import 'package:sss_mobile/screens/trip_screen.dart';


class VehicleDetailScreen extends StatefulWidget {
  final Vehicle vehicle;

  VehicleDetailScreen(this.vehicle);

  @override
  createState() => new VehicleDetailScreenState(vehicle);
}

class VehicleDetailScreenState extends State<VehicleDetailScreen> {
  RefreshController _refreshTrips = RefreshController(initialRefresh: true);
  RefreshController _refreshMaintenance =
  RefreshController(initialRefresh: true);
  RefreshController _refreshRefuelings =
  RefreshController(initialRefresh: true);

  final Vehicle vehicle;
  var _trips = <Trip>[];
  var _refuelings = <Refueling>[];
  var _maintenance = <Maintenance>[];

  VehicleDetailScreenState(this.vehicle);

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    _loadData();
    _refreshMaintenance.refreshToIdle();
    _refreshRefuelings.refreshToIdle();
    _refreshTrips.refreshToIdle();
  }

  _loadData() async {
    var futures = <Future>[];

    futures.add(VehicleAPI().fetchMaintenancesFor(vehicle).then((data) {
      setState(() {
        _maintenance = data;
        _refreshMaintenance.refreshCompleted();
      });
    }).catchError((Object error) {
      print(error);
      _refreshMaintenance.refreshFailed();
    }));

    futures.add(VehicleAPI().fetchRefuelingsFor(vehicle).then((data) {
      setState(() {
        _refuelings = data;
        _refreshRefuelings.refreshCompleted();
      });
    }).catchError((Object error) {
      print(error);
      _refreshRefuelings.refreshFailed();
    }));

    futures.add(VehicleAPI().fetchTripsFor(vehicle).then((data) {
      setState(() {
        _trips = data;
        _refreshTrips.refreshCompleted();
      });
    }).catchError((Object error) {
      print(error);
      _refreshTrips.refreshFailed();
    }));

    await Future.wait(futures).catchError((error) {
      print('Data se nepodařilo stáhnout ze SSS API');
    });
  }

  Widget _buildRowForTrip(int i) {
    return new ListTile(
      subtitle: new Text("${_trips[i].id}"),
      title: new Text("${_trips[i].beginOdometer} - ${_trips[i].endOdometer}"),
      onTap: () {
        print('object');
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => TripScreen(trip: _trips[i])));
      },
    );
  }

  Widget _buildRowForMaintenance(int i) {
    return new ListTile(
      subtitle: new Text("${_maintenance[i].user.name}"),
      title: new Text("${_maintenance[i].state} - ${_maintenance[i].note}"),
    );
  }

  Widget _buildRowForRefueling(int i) {
    return new ListTile(
      subtitle: new Text("${_refuelings[i].user.name}"),
      title: new Text(
          "${_refuelings[i].odometer} km - ${_refuelings[i].fuelAmount} litres"),
      onTap: () {

      },
    );
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
          title: Text(vehicle.name),
        ),
        body: TabBarView(
          children: [
            Scaffold(
                body: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropHeader(),
                  controller: _refreshTrips,
                  onRefresh: _loadData,
                  child: new ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _trips.length,
                      itemBuilder: (BuildContext context, int position) {
                        return _buildRowForTrip(position);
                      }),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TripScreen()));
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
                  onRefresh: _loadData,
                  child: new ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _refuelings.length,
                      itemBuilder: (BuildContext context, int position) {
                        return _buildRowForRefueling(position);
                      }),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: _goToTheLake,
                  label: Text('Přidat Tankování'),
                  icon: Icon(Icons.local_gas_station),
                )),
            Scaffold(
              body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(),
                controller: _refreshMaintenance,
                onRefresh: _loadData,
                child: new ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _maintenance.length,
                    itemBuilder: (BuildContext context, int position) {
                      return _buildRowForMaintenance(position);
                    }),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: _goToTheLake,
                label: Text('Přidat Servis'),
                icon: Icon(Icons.build),
              ),
            ),
            new Scaffold(
              body: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
