import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/widgets/table_row_with_padding.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/refuelings/vehicle_detail_refuelings_cubit.dart';

class RefuelingList extends StatelessWidget {
  final List<Refueling> refuelings;
  final DateFormat dateFormat = DateFormat.yMMMEd();

  RefuelingList({Key key, this.refuelings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<VehicleDetailRefuelingsCubit, VehicleDetailRefuelingsState>(
          listener: (context, state) {
            if (state is VehicleDetailRefuelingsErrorDeleting) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.current.failedDelete),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: _buildList(refuelings)),
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
                buildTableRowWithPadding(S.current.date, dateFormat.format(data.date)),
                buildTableRowWithPadding(
                    S.current.odometer, data.odometer.toString() ?? 0.toString()),
                buildTableRowWithPadding(
                    S.current.price, data.price.toString() + ' ' + data.currency ?? ''),
                buildTableRowWithPadding(
                    S.current.officialTrip, data.official ? S.current.yes : S.current.no),
                buildTableRowWithPadding(S.current.note, data.note ?? ''),
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
                  BlocProvider.of<VehicleDetailRefuelingsCubit>(context).delete(data.id);
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

  Widget _buildList(List<Refueling> refuelings) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: refuelings.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildRow(context, refuelings[position]);
        });
  }
}
