import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sss_mobile/models/vehicle.dart';
import 'package:sss_mobile/screens/vehicle_detail_screen.dart';
import 'package:sss_mobile/vehicles/vehicle_bloc.dart';
import 'package:sss_mobile/vehicles/vehicle_event.dart';
import 'package:sss_mobile/vehicles/vehicle_state.dart';

class Vehicles extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  Widget _buildRow(BuildContext context, int i, List<Vehicle> data) {
    return new ListTile(
      subtitle: new Text("${data[i].spz}"),
      title: new Text("${data[i].name}"),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleDetailScreen(data[i])));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Weather'),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<VehicleBloc>(context).add(TESTEvent());
                  },
                  child: Icon(Icons.error),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<VehicleBloc>(context).add(FetchVehicles());
                  },
                  child: Icon(Icons.refresh),
                )),
          ],
          bottom: TabBar(
            tabs: [Tab(icon: Icon(Icons.domain), text: "Company Vehicles"), Tab(icon: Icon(Icons.person), text: "Personal Vehicles")],
          ),

        ),
        body: Center(
          child: BlocBuilder<VehicleBloc, VehicleState>(
            builder: (context, state) {
              if (state is VehicleEmpty) {
                BlocProvider.of<VehicleBloc>(context).add(FetchVehicles());
                return Center(child: Text('Please Select a Location'));
              }
              if (state is VehicleLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is VehicleLoaded) {
                final vehicles = state.vehicles;
                final _companySPZ = ["5A54291", "1AC8423", "2AM7900", "6AB7175", "6AD2452", "6AE2712", "5A48356"];

                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropHeader(),
                  controller: _refreshController,
                  onRefresh: () => BlocProvider.of<VehicleBloc>(context).add(FetchVehicles()),
                  child: TabBarView(
                    children: [
                      new ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: vehicles.where((v) => _companySPZ.contains(v.spz)).length,
                          itemBuilder: (BuildContext context, int position) {
                            return _buildRow(context, position, vehicles.where((v) => _companySPZ.contains(v.spz)).toList());
                          }),
                      new ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: vehicles.where((v) => !_companySPZ.contains(v.spz)).length,
                          itemBuilder: (BuildContext context, int position) {
                            return _buildRow(context, position, vehicles.where((v) => !_companySPZ.contains(v.spz)).toList());
                          }),
                    ],
                  ),
                );
              }
//            if (state is WeatherError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
//            }
            },
          ),
        ),
      ),
    );
  }
}
