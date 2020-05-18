import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sss_mobile/apis/vehicle_api.dart';
import 'package:sss_mobile/blocs/trip/trip_bloc.dart';
import 'package:sss_mobile/blocs/trip/trip_event.dart';
import 'package:sss_mobile/blocs/trip/trip_state.dart';
import 'package:sss_mobile/models/trip.dart';
import 'package:sss_mobile/models/vehicle.dart';

class TripPage extends StatefulWidget {

  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  final _formKey = GlobalKey<FormState>();

  Trip trip = Trip();
  Vehicle vehicle;

  _TripPageState();

  var beginDateController = TextEditingController();
  var endDateController = TextEditingController();

  Future<Null> _selectDate(BuildContext context, bool begin) async {
    final DateTime picked = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime.now());

    if (picked != null)
      setState(() {
        var formatter = new DateFormat('dd.M.yyyy');
        if (begin) {
          trip.beginDate = picked;
          beginDateController.text = formatter.format(trip.beginDate);
        } else {
          trip.endDate = picked;
          endDateController.text = formatter.format(trip.endDate);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(builder: (context, state) {
      if (state is TripSuccess) {
        Navigator.of(context).pop();
      }

      if (state is TripWithData) {
        this.trip = state.trip;
        var formatter = new DateFormat('dd.M.yyyy');
        if (trip.beginDate != null) {
          beginDateController.text = formatter.format(trip.beginDate);
        }

        if (trip.endDate != null) {
          endDateController.text = formatter.format(trip.endDate);
        }
      }

        return Scaffold(
            appBar: AppBar(title: trip.id != null ? Text('Upravit jízdu') : Text('Nová jízda')),
            body: Container(
                child: Builder(
                    builder: (context) => Form(
                          key: _formKey,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    flex: 5,
                                    child: TextFormField(
                                      initialValue: trip.beginOdometer.toString(),
                                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                                      decoration: InputDecoration(labelText: 'Počáteční stav km'),
                                      validator: (value) {
                                        try {
                                          int.parse(value);
                                        } catch (_) {
                                          return 'Neplatná hodnota';
                                        }

                                        if (value.isEmpty) {
                                          return 'Zadejte prosím hodnotu';
                                        }
                                        return null;
                                      },
                                      onSaved: (val) => setState(() => trip.beginOdometer = int.parse(val)),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: TextFormField(
                                      initialValue: trip.endOdometer.toString(),
                                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                                      decoration: InputDecoration(labelText: 'Konečný stav km'),
                                      validator: (value) {
                                        try {
                                          int.parse(value);
                                        } catch (_) {
                                          return 'Neplatná hodnota';
                                        }

                                        if (value.isEmpty) {
                                          return 'Zadejte prosím hodnotu';
                                        }
                                        return null;
                                      },
                                      onSaved: (val) => setState(() => trip.endOdometer = int.parse(val)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 5,
                                    child: TextFormField(
                                      decoration: InputDecoration(labelText: 'Počáteční datum'),
                                      controller: beginDateController,
                                      onTap: () {
                                        _selectDate(context, true);
                                      },
                                      readOnly: true,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: TextFormField(
                                      decoration: InputDecoration(labelText: 'Konečné datum'),
                                      controller: endDateController,
                                      onTap: () {
                                        _selectDate(context, false);
                                      },
                                      readOnly: true,
                                    ),
                                  )
                                ],
                              ),
                              Flexible(
                                child: LabeledSwitch(
                                  label: "Firemní cesta",
                                  value: trip.officialTrip != null ? trip.officialTrip : true,
                                  onChanged: (bool value) {
                                    setState(() {
                                      trip.officialTrip = value;
                                    });
                                  },
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                                  child: Text(
                                    'Palivo',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )),
                              SliderTheme(
                                data: SliderThemeData(
                                  trackShape: CustomTrackShape(),
                                ),
                                child: Slider(
                                  min: 0,
                                  value: trip.fuelStatus != null ? trip.fuelStatus.toDouble() : 0,
                                  max: 100,
                                  label: '${trip.fuelStatus} %',
                                  divisions: 100,
                                  onChanged: (value) {
                                    setState(() {
                                      trip.fuelStatus = value.toInt();
                                    });
                                  },
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(labelText: 'Účel cesty'),
                              ),
                              TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(labelText: 'Poznámka k parkování'),
                                  onSaved: (val) => setState(() => trip.parkingNote = val)),
                              RaisedButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();

                                      BlocListener<TripBloc, TripState>(
                                          listener: (context, state) {
                                            if (state is TripSaving) {
                                              Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Ukládání....'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          });

                                      BlocListener<TripBloc, TripState>(
                                          listener: (context, state) {
                                            if (state is TripError) {
                                              showDialog(context: context, child: Text(state.message));
                                            }
                                          });

                                      BlocProvider.of<TripBloc>(context).add(SaveTrip(trip, vehicle));
                                    }
                                  },
                                  child: Text('Uložit'))
                            ]),
                          ),
                        ))));
      
    });
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Switch(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
