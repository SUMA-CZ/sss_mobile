import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/trip/cubit/trip_form_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/trip/trip_form.dart';

import '../../../../../injection_container.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;
  final Vehicle vehicle;

  TripList({@required this.trips, @required this.vehicle}) : assert(vehicle != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTripsList(trips),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => BlocProvider<TripFormCubit>(
                    create: (context) => sl<TripFormCubit>(param1: vehicle),
                    child: TripForm(lastTrip: trips.first))),
          );
        },
        label: Text(S.current.addTrip),
        icon: Icon(Icons.add_circle_outline),
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
          )
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
