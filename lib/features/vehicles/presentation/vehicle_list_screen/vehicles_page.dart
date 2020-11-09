import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sss_mobile/core/authorization/auth_bloc.dart';
import 'package:sss_mobile/core/authorization/auth_events.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/vehicle_detail_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/vehicle_detail_screen.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_list_screen/bloc/get_vehicles_bloc.dart';

import '../../../../injection_container.dart';
import '../../../../string.dart';

class VehiclesPage extends StatelessWidget {
  final _companySPZ = ["5A54291", "1AC8423", "2AM7900", "6AB7175", "6AD2452", "6AE2712", "5A48356"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                      child: Icon(Icons.exit_to_app),
                    )),
              ],
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.domain), text: "Company Vehicles"),
                  Tab(icon: Icon(Icons.person), text: "Personal Vehicles")
                ],
              ),
            ),
            body: BlocBuilder<GetVehiclesBloc, GetVehiclesState>(
              builder: (context, state) {
                if (state is GetVehiclesStateLoaded) {
                  return TabBarView(
                    children: [
                      new ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount:
                              state.vehicles.where((v) => _companySPZ.contains(v.spz)).length,
                          itemBuilder: (BuildContext context, int position) {
                            return _buildCompanyVehicleRow(context, position, state.vehicles);
                          }),
                      new ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: state.vehicles.length,
                          itemBuilder: (BuildContext context, int position) {
                            return _buildPersonalVehicleRow(context, position, state.vehicles);
                          }),
                    ],
                  );
                }

                if (state is GetVehiclesStateError) {
                  return _buildErrorMessageAndRefresh(context, state.message);
                }

                return Center(child: CircularProgressIndicator());
              },
            )));
  }

  Widget _buildErrorMessageAndRefresh(BuildContext context, String message) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(message),
            RaisedButton(
                child: Text('REFRESH'),
                onPressed: () =>
                    BlocProvider.of<GetVehiclesBloc>(context)..add(GetVehiclesEventGetVehicles()))
          ]),
    );
  }

  Widget _buildCompanyVehicleRow(BuildContext context, int i, List<Vehicle> _vehicles) {
    var filtered = _vehicles.where((v) => _companySPZ.contains(v.spz)).toList();
    return _buildRow(context, i, filtered);
  }

  Widget _buildPersonalVehicleRow(BuildContext context, int i, List<Vehicle> _vehicles) {
    var filtered = _vehicles.where((v) => !_companySPZ.contains(v.spz)).toList();
    return _buildRow(context, i, filtered);
  }

  Widget _buildRow(BuildContext context, int i, List<Vehicle> data) {
    return new ListTile(
      subtitle: new Text("${data[i].spz}"),
      title: new Text("${data[i].name}"),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider<VehicleDetailCubit>(
                      create: (context) => VehicleDetailCubit(
                          vehicleRepository: sl<VehicleRepository>(), vehicle: data[i]),
                      child: VehicleDetailScreen(),
                    )));
      },
    );
  }
}
