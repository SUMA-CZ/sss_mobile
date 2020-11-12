import 'package:flutter/material.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/trip/trip_form.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;

  TripList({@required this.trips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTripsList(trips),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          /// Get cubit and pass it to next page
          // Add your onPressed code here!

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TripForm()),
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
                _buildTableRowWithPadding('Počáteční datum', data.beginDate.toString()),
                _buildTableRowWithPadding('Konečné datum', data.endDate.toString()),
                _buildTableRowWithPadding('Počáteční stav km', data.beginOdometer.toString()),
                _buildTableRowWithPadding('Konečný stav km', data.endOdometer.toString()),
                _buildTableRowWithPadding('Pracovní cesta', data.officialTrip ? 'Ano' : 'Ne'),
                _buildTableRowWithPadding('Poznámka k parkování', data.parkingNote.toString()),
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
