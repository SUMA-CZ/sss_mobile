import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sss_mobile/apis/vehicle_api.dart';
import 'package:sss_mobile/models/trip.dart';
import 'package:sss_mobile/models/vehicle.dart';

class TripScreen extends StatefulWidget {
  final Trip trip;
  final Vehicle vehicle;

  TripScreen(this.trip, this.vehicle);

  @override
  _TripScreenState createState() => _TripScreenState(trip, vehicle);
}

class _TripScreenState extends State<TripScreen> {
  final _formKey = GlobalKey<FormState>();

  Trip trip = Trip();
  Vehicle vehicle;

  _TripScreenState(this.trip, this.vehicle);

  var beginDateController = TextEditingController();
  var endDateController = TextEditingController();

  Future<Null> _selectDate(BuildContext context, bool begin) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime.now());

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
                              keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                              decoration: InputDecoration(labelText: 'Počáteční stav km'),
                              validator: (value) {
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
                              keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                              decoration: InputDecoration(labelText: 'Konečný stav km'),
                              validator: (value) {
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
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Ukládání...')));
                              VehicleAPI()
                                  .saveVehicle(vehicle, trip)
                                  .then((value) => {Navigator.pop(context)}, onError: (error) =>
                              {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Záznam se nepodařilo uložit')))
                              });
                            }
                          },
                          child: Text('Uložit'))
                    ]),
                  ),
                ))));
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
