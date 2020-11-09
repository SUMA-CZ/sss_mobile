import 'package:flutter/material.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';

class MaintenanceList extends StatelessWidget {
  final List<Maintenance> maintenances;

  MaintenanceList({@required this.maintenances});

  @override
  Widget build(BuildContext context) {
    return _buildList(maintenances);
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

  Widget _buildRow(BuildContext context, Maintenance data) {
    return Card(
      child: ExpansionTile(
        title: Text(data.user.name),
        subtitle: Text(data.description ?? '-'),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(),
              children: [
                _buildTableRowWithPadding('Datum', data.date.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(List<Maintenance> refuelings) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: refuelings.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildRow(context, refuelings[position]);
        });
  }
}
