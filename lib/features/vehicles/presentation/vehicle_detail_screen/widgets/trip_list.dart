import 'package:flutter/material.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;

  TripList({@required this.trips});

  @override
  Widget build(BuildContext context) {
    return _buildTripsList(trips);
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
