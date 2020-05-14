import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sss_mobile/auth/auth_bloc.dart';
import 'package:sss_mobile/auth/auth_events.dart';
import 'package:sss_mobile/models/vehicle.dart';
import 'package:sss_mobile/networking/vehicle_api.dart';
import 'package:sss_mobile/screens/vehicle_detail_screen.dart';
import 'package:sss_mobile/string.dart';

class VehicleListScreenState extends State<VehicleListScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  var _vehicles = <Vehicle>[];
  // TODO: Fill in all the data
  final _companySPZ = ["5A54291", "1AC8423", "2AM7900", "6AB7175", "6AD2452", "6AE2712", "5A48356"];

  void _onRefresh() async{
    await _loadVehicles();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new AppBar(
            title: new Text(Strings.appTitle),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                    },
                    child: Icon(
                        Icons.exit_to_app
                    ),
                  )
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.domain), text: "Company Vehicles"),
                Tab(icon: Icon(Icons.person), text: "Personal Vehicles")
              ],
            ),
          ),
          body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child:  TabBarView(
                children: [
                  new ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _vehicles.where((v) => _companySPZ.contains(v.spz)).length,
                      itemBuilder: (BuildContext context, int position) {
                        return _buildCompanyVehicleRow(position);
                      }),
                  new ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _vehicles.length,
                      itemBuilder: (BuildContext context, int position) {
                        return _buildPersonalVehicleRow(position);
                      }),
                ],
              ),
          ),
        ),
        )
    );
  }

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Widget _buildCompanyVehicleRow(int i) {
    var filtered = _vehicles.where((v) => _companySPZ.contains(v.spz)).toList();
    return _buildRow(i, filtered);
  }

  Widget _buildPersonalVehicleRow(int i) {
    var filtered = _vehicles.where((v) => !_companySPZ.contains(v.spz)).toList();
    return _buildRow(i, filtered);
  }

  Widget _buildRow(int i, List<Vehicle> data) {
    return new ListTile(
        subtitle: new Text("${data[i].spz}"),
        title: new Text("${data[i].name}"),
      onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleDetailScreen(data[i])));

      },
    );
  }

  _loadVehicles() async {
    VehicleAPI().fetchVehicles().then((onValue) {
      setState(() {
        this._vehicles = onValue;
        _refreshController.refreshCompleted();
      });
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("API Error"),
            content: new Text("Could not download data"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      _refreshController.refreshCompleted();
    });
  }
}

class VehicleListScreen extends StatefulWidget {
  @override
  createState() => new VehicleListScreenState();
}