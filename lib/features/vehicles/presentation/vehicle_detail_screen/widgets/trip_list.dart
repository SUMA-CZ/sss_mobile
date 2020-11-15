import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/trip/cubit/trip_form_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/trip/trip_form.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/trips/vehicle_detail_trips_cubit.dart';

import '../../../../../injection_container.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;
  final Vehicle vehicle;

  TripList({@required this.trips, @required this.vehicle}) : assert(vehicle != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<VehicleDetailTripsCubit, VehicleDetailTripsState>(
        listener: (context, state) {
          if (state is VehicleDetailTripsErrorDeleting) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(S.current.failedDelete),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: _buildTripsList(trips),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var tripListCubit = BlocProvider.of<VehicleDetailTripsCubit>(context);

          Navigator.push(
            context,
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => BlocProvider<TripFormCubit>(
                    create: (context) => sl<TripFormCubit>(param1: vehicle, param2: tripListCubit)
                      ..setLastTrip(trips.first),
                    child: TripForm())),
          );
        },
        label: Text(S.current.addTrip, style: TextStyle(color: Colors.white)),
        icon: Icon(
          Icons.add_circle_outline,
          color: Colors.white,
        ),
      ),
    );
  }

  TableRow _buildTableRowWithPadding(String left, String right) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(left),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(right),
      )
    ]);
  }

  Widget _buildRowForTrips(BuildContext context, Trip data) {
    return Card(
      child: ExpansionTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${data.endOdometer - data.beginOdometer} km'),
          ],
        ),
        title: Text(data.user.name),
        subtitle: Text(data.note ?? ''),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(),
              children: [
                _buildTableRowWithPadding(S.current.beginDate, data.beginDate.toString()),
                _buildTableRowWithPadding(S.current.endData, data.endDate.toString()),
                _buildTableRowWithPadding(S.current.beginOdometer, data.beginOdometer.toString()),
                _buildTableRowWithPadding(S.current.endOdometer, data.endOdometer.toString()),
                _buildTableRowWithPadding(S.current.officialTrip, data.officialTrip ? 'Ano' : 'Ne'),
                _buildTableRowWithPadding(S.current.parkingNote, data.parkingNote.toString()),
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              // FlatButton(
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              //   onPressed: () {
              //     // BlocProvider.of<VehicleDetailTripsCubit>(context)
              //   },
              //   child: Column(
              //     children: <Widget>[
              //       Icon(Icons.create_outlined, color: Theme.of(context).accentColor),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 2.0),
              //       ),
              //       Text(S.current.edit, style: TextStyle(color: Theme.of(context).accentColor)),
              //     ],
              //   ),
              // ),
              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                onPressed: () {
                  BlocProvider.of<VehicleDetailTripsCubit>(context).deleteTrip(data.id);
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.delete_outline, color: Theme.of(context).accentColor),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text(S.current.delete, style: TextStyle(color: Theme.of(context).accentColor)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTripsList(List<Trip> trips) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: trips.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildRowForTrips(context, trips[position]);
        });
  }
}
