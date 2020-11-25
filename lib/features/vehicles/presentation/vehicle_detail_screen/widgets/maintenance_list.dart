import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/alerts.dart';
import 'package:sss_mobile/core/ui/widgets/table_row_with_padding.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/maintenances/maintenances_cubit.dart';

class MaintenanceList extends StatelessWidget {
  final List<Maintenance> maintenances;
  final DateFormat dateFormat = DateFormat.yMMMEd();

  MaintenanceList({@required this.maintenances});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MaintenancesCubit, MaintenancesState>(
          listener: (context, state) {
            if (state is MaintenancesStateErrorDeleting) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.current.failedDelete),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: _buildList(maintenances)),
    );
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
                buildTableRowWithPadding(S.current.date, dateFormat.format(data.date)),
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
                    BlocProvider.of<MaintenancesCubit>(context).delete(data.id);
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

  Widget _buildList(List<Maintenance> refuelings) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: refuelings.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildRow(context, refuelings[position]);
        });
  }
}
