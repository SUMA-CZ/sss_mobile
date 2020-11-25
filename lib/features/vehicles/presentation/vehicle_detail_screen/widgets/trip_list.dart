import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/alerts.dart';
import 'package:sss_mobile/core/ui/widgets/table_row_with_padding.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/trip/cubit/trip_form_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/trip/trip_form.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/trips/trips_cubit.dart';

import '../../../../../injection_container.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;
  final Vehicle vehicle;
  final DateFormat dateFormat = DateFormat.yMMMEd();

  TripList({@required this.trips, @required this.vehicle}) : assert(vehicle != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TripsCubit, TripsState>(
        listener: (context, state) {
          if (state is TripsStateErrorDeleting) {
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
          var tripListCubit = BlocProvider.of<TripsCubit>(context);

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
        label: Text(S.current.addTrip),
        icon: Icon(Icons.add_circle_outline),
      ),
    );
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
                buildTableRowWithPadding(S.current.beginDate, dateFormat.format(data.beginDate)),
                buildTableRowWithPadding(S.current.endData, dateFormat.format(data.endDate)),
                buildTableRowWithPadding(S.current.beginOdometer, data.beginOdometer.toString()),
                buildTableRowWithPadding(S.current.endOdometer, data.endOdometer.toString()),
                buildTableRowWithPadding(S.current.officialTrip, data.officialTrip ? 'Ano' : 'Ne'),
                buildTableRowWithPadding(S.current.parkingNote, data.parkingNote ?? ''),
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                onPressed: () {
                  showDeleteAlertDialog(context, () {
                    BlocProvider.of<TripsCubit>(context).delete(data.id);
                  });
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
