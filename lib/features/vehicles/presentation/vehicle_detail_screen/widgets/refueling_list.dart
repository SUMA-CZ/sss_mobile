import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/widgets/table_row_with_padding.dart';
import 'package:sss_mobile/features/login/domain/repositories/user_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/refueling/cubit/refueling_form_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/refueling/refueling_form.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/refuelings/refuelings_cubit.dart';

import '../../../../../injection_container.dart';

class RefuelingList extends StatelessWidget {
  final List<Refueling> refuelings;
  final Vehicle vehicle;

  final DateFormat dateFormat = DateFormat.yMMMEd();

  RefuelingList({Key key, this.refuelings, this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RefuelingsCubit, RefuelingsState>(
          listener: (context, state) {
            if (state is RefuelingsStateErrorDeleting) {
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
          var tripListCubit = BlocProvider.of<RefuelingsCubit>(context);

          Navigator.push(
            context,
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => BlocProvider<RefuelingFormCubit>(
                    create: (context) =>
                        sl<RefuelingFormCubit>(param1: vehicle, param2: tripListCubit)..getLoaded(),
                    child: RefuelingForm())),
          );
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
          Image(
              image: NetworkImage(data.scanURL + '/download', headers: {
            'Authorization': 'Bearer ' + sl<UserRepository>().accessTokenForImage()
          })),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                onPressed: () {
                  BlocProvider.of<RefuelingsCubit>(context).delete(data.id);
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
