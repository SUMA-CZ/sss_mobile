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
        lastDate: DateTime.now());

    if (picked != null)
      setState(() {
        if (begin) {
          trip.beginDate = picked;
          beginDateController.text = trip.beginDate.toString();
        } else {
          trip.endDate = picked;
          endDateController.text = trip.endDate.toString();
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              flex: 5,
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
                                onSaved: (val) => setState(
                                    () => trip.beginOdometer = int.parse(val)),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Flexible(
                              flex: 5,
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
                                onSaved: (val) => setState(
                                    () => trip.endOdometer = int.parse(val)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Počáteční datum'),
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
                                decoration:
                                    InputDecoration(labelText: 'Konečné datum'),
                                controller: endDateController,
                                onTap: () {
                                  _selectDate(context, true);
                                },
                                readOnly: true,
                              ),
                            )
                          ],
                        ),
                        SwitchListTile(
                          title: const Text('Lights'),
                          value: trip.officialTrip,
                          onChanged: (bool value) {
                            setState(() {
                              trip.officialTrip = value;
                            });
                          },
                          secondary: const Icon(Icons.lightbulb_outline),
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
                            value: trip.fuelStatus != null
                                ? trip.fuelStatus.toDouble()
                                : 0,
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
                            decoration: InputDecoration(
                                labelText: 'Poznámka k parkování'),
                            onSaved: (val) =>
                                setState(() => trip.parkingNote = val)),
                      ]),
                    )))));
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
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
