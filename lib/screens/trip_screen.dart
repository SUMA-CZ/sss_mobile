import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sss_mobile/models/trip.dart';

class TripScreen extends StatefulWidget {
  final Trip trip;

  TripScreen({Key key, Trip trip})
      : trip = trip ?? Trip(); // : super(key: key);

  @override
  _TripScreenState createState() => _TripScreenState(trip);
}

class _TripScreenState extends State<TripScreen> {
  final _formKey = GlobalKey();

  Trip trip = Trip();

  _TripScreenState(this.trip);

  var beginDateController = TextEditingController();
  var endDateController = TextEditingController();

  Future<Null> _selectDate(BuildContext context, bool begin) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null)
      setState(() {
        if (begin) {
          trip.beginDate = picked;
          beginDateController.text = trip.beginDate.toString();
        } else {
          trip.endDate = picked;
          endDateController.text = trip.beginDate.toString();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
            trip.id != null ? Text('Upravit jízdu') : Text('Nová jízda')),
        body: Container(
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Container(
                      child: Column(children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true, signed: false),
                                  decoration: InputDecoration(
                                      labelText: 'Počáteční stav km'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Zadejte prosím hodnotu';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) =>
                                      setState(() =>
                                      trip.beginOdometer = int.parse(val)),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true, signed: false),
                                  decoration: InputDecoration(
                                      labelText: 'Konečný stav km'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Zadejte prosím hodnotu';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) =>
                                      setState(
                                              () =>
                                          trip.endOdometer = int.parse(val)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Počáteční datum'),
                                  controller: beginDateController,
                                  initialValue: trip.beginDate != null
                                      ? trip.beginDate.toString()
                                      : "",
                                  onTap: () {
                                    _selectDate(context, true);
                                  },
                                  readOnly: true,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Konečné datum'),
                                  controller: endDateController,
                                  initialValue: trip.endDate != null
                                      ? trip.endDate.toString()
                                      : "",
                                  onTap: () {
                                    _selectDate(context, true);
                                  },
                                  readOnly: true,
                                ),
                              ),
                            )
                          ],
                        )
                      ]),
                    )))));
  }
}
