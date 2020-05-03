import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sss_mobile/networking/vehicle_factory.dart';
import 'package:sss_mobile/models/maintenance.dart';
import 'package:sss_mobile/models/refueling.dart';
import 'package:sss_mobile/models/trip.dart';
import 'package:sss_mobile/models/vehicle.dart';
import 'package:sss_mobile/screens/new_trip_screen.dart';

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
    }).catchError((){
      _refreshMaintenance.refreshFailed();
    }));

    futures.add(VehicleAPI().fetchRefuelingsFor(vehicle).then((data) {
      setState(() {
        _refuelings = data;
        _refreshRefuelings.refreshCompleted();
      });
    }).catchError((){
      _refreshRefuelings.refreshFailed();
    }));

    futures.add(VehicleAPI().fetchTripsFor(vehicle).then((data) {
      setState(() {
        _trips = data;
        _refreshTrips.refreshCompleted();
      });
    }).catchError((){
      _refreshTrips.refreshFailed();
    }));

    await Future.wait(futures).catchError((error) {
      print('Data se nepodařilo stáhnout ze SSS API');
    });
  }

  _routeToNew() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Nový Záznam"),
          content: new Text("Vyber typ záznamu"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new  Icon(Icons.directions_car),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeMaterial()));
              },
            ),
            new FlatButton(
              child: new Icon(Icons.local_gas_station),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Icon(Icons.build),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildRowForTrip(int i) {
    return new ListTile(
      subtitle: new Text("${_trips[i].id}"),
      title: new Text("${_trips[i].beginOdometer} - ${_trips[i].endOdometer}"),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _routeToNew,
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.local_gas_station)),
              Tab(icon: Icon(Icons.build)),
            ],
          ),
          title: Text(vehicle.name),
        ),
        body: TabBarView(
          children: [
            SmartRefresher(
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
            SmartRefresher(
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
            SmartRefresher(
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
          ],
        ),
      ),
    );
  }
}

class VehicleDetailScreen extends StatefulWidget {
  final Vehicle vehicle;

  VehicleDetailScreen(this.vehicle);

  @override
  createState() => new VehicleDetailScreenState(vehicle);
}
