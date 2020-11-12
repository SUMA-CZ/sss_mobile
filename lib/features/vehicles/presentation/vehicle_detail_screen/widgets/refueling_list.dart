import 'package:flutter/material.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';

class RefuelingList extends StatelessWidget {
  final List<Refueling> refuelings;

  const RefuelingList({Key key, this.refuelings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(refuelings),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          /// Get cubit and pass it to next page
          // Add your onPressed code here!
        },
        label: Text(S.current.addRefueling),
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

  Widget _buildRow(BuildContext context, Refueling data) {
    return Card(
      child: ExpansionTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${data.fuelAmount ?? '?'} l'),
          ],
        ),
        title: Text(data.user.name),
        subtitle: Text(data.note ?? '-'),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(),
              children: [
                _buildTableRowWithPadding('Datum', data.date.toString()),
                _buildTableRowWithPadding('Odometr', data.odometer.toString() ?? 0.toString()),
                _buildTableRowWithPadding(
                    'Cena', data.price.toString() + ' ' + data.currency ?? ''),
                _buildTableRowWithPadding('Pracovní cesta', data.official ? 'Ano' : 'Ne'),
                _buildTableRowWithPadding('Poznámka', data.note ?? ''),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(List<Refueling> refuelings) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: refuelings.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildRow(context, refuelings[position]);
        });
  }
}
