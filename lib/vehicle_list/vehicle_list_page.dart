import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sss_mobile/models/vehicle.dart';
import 'package:sss_mobile/screens/vehicle_detail_screen.dart';
import 'package:sss_mobile/vehicle_list/vehicle_list.dart';

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
                    BlocProvider.of<VehicleListBloc>(context).add(TestVehicleList());
                  },
                  child: Icon(Icons.error),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<VehicleListBloc>(context).add(FetchVehiclesList());
                  },
                  child: Icon(Icons.refresh),
                )),
          ],
          bottom: TabBar(
            tabs: [Tab(icon: Icon(Icons.domain), text: "Company Vehicles"), Tab(icon: Icon(Icons.person), text: "Personal Vehicles")],
          ),

        ),
        body: Center(
          child: BlocBuilder<VehicleListBloc, VehicleListState>(
            builder: (context, state) {
              if (state is VehicleListEmpty) {
                BlocProvider.of<VehicleListBloc>(context).add(FetchVehiclesList());
                return Center(child: Text('Please Select a Location'));
              }
              if (state is VehicleListLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is VehicleListLoaded) {
                final vehicles = state.vehicles;

                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropHeader(),
                  controller: _refreshController,
                  onRefresh: () => BlocProvider.of<VehicleListBloc>(context).add(FetchVehiclesList()),
                  child: TabBarView(
                    children: [
                      new ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: vehicles
                              .where((v) => v.companyVehicle())
                              .length,
                          itemBuilder: (BuildContext context, int position) {
                            return _buildRow(context, position, vehicles.where((v) => v.companyVehicle()).toList());
                          }),
                      new ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: vehicles
                              .where((v) => !v.companyVehicle())
                              .length,
                          itemBuilder: (BuildContext context, int position) {
                            return _buildRow(context, position, vehicles.where((v) => !v.companyVehicle()).toList());
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
