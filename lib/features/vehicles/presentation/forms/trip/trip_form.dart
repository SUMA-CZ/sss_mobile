import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_map_field/form_builder_map_field.dart';
import 'package:intl/intl.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/widgets/loading_indicator.dart';
import 'package:sss_mobile/features/vehicles/data/models/trip_model.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/trip/cubit/trip_form_cubit.dart';

class TripForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final ValueChanged _onChanged = (val) => print(val);

  Map<String, dynamic> _initialDataFor(TripFormState state) {
    if (state is TripFormEdit) {
      return state.trip.toFormEditJSON();
    } else if (state is TripFormLoaded) {
      return state.trip.toFormNextJSON();
    }
    return {
      'OfficialJourney': true,
      'FuelStatus': 0.5,
      'date_range': [DateTime.now(), DateTime.now()],
      'InitialOdometer': 0,
      'FinalOdometer': 0,
      'Note': '',
      'ParkingNote': ''
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.addTrip),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocListener<TripFormCubit, TripFormState>(
              listener: (context, state) {
                if (state is TripFormError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.current.failedToSaveTrip),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if (state is TripFormCreated) {
                  Navigator.of(context).pop();
                }
              },
              child: BlocBuilder<TripFormCubit, TripFormState>(builder: (context, state) {
                if (state is TripFormInitial || state is TripFormLoaded) {
                  return ListView(
                    children: <Widget>[
                      FormBuilder(
                        // context,
                        key: _fbKey,
                        initialValue: _initialDataFor(state),
                        readOnly: false,
                        child: Column(
                          children: <Widget>[
                            FormBuilderSwitch(
                              label: Text(S.current.officialTrip),
                              attribute: 'OfficialJourney',
                              initialValue: true,
                              activeColor: Theme.of(context).accentColor,
                              onChanged: _onChanged,
                            ),
                            FormBuilderSlider(
                              attribute: 'FuelStatus',
                              onChanged: _onChanged,
                              validators: [FormBuilderValidators.required()],
                              numberFormat: NumberFormat('0 %'),
                              min: 0,
                              max: 1,
                              // initialValue: 0.5,
                              divisions: 10,
                              activeColor: Theme.of(context).accentColor,
                              decoration: InputDecoration(
                                labelText: S.current.fuelLevel,
                              ),
                              displayValues: DisplayValues.current,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: FormBuilderDateRangePicker(
                                    attribute: 'date_range',
                                    validators: [FormBuilderValidators.required()],
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime.now(),
                                    initialValue: [
                                      DateTime.now().subtract(Duration(seconds: 30)),
                                      DateTime.now().subtract(Duration(seconds: 10))
                                    ],
                                    format: DateFormat.yMMMMd(),
                                    onChanged: _onChanged,
                                    decoration: InputDecoration(labelText: S.current.dateInterval),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: FormBuilderTextField(
                                  attribute: 'InitialOdometer',
                                  decoration: InputDecoration(
                                    labelText: S.current.beginOdometer,
                                  ),
                                  validators: [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                  ],
                                  keyboardType: TextInputType.number,
                                )),
                                SizedBox(width: 20),
                                Expanded(
                                    child: FormBuilderTextField(
                                  attribute: 'FinalOdometer',
                                  // initialValue: '27',
                                  decoration: InputDecoration(
                                    labelText: S.current.endOdometer,
                                  ),
                                  validators: [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                  ],

                                  keyboardType: TextInputType.number,
                                )),
                              ],
                            ),
                            FormBuilderTextField(
                              attribute: 'Note',
                              initialValue: 'Note',
                              validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(
                                labelText: S.current.description,
                              ),
                              minLines: 2,
                              maxLines: 10,
                            ),
                            FormBuilderTextField(
                              initialValue: 'Parking Note',
                              attribute: 'ParkingNote',
                              decoration: InputDecoration(
                                labelText: S.current.parkingNote,
                              ),
                              minLines: 2,
                              maxLines: 10,
                            ),
                            FormBuilderMapField(
                                initialValue: CameraPosition(
                                    bearing: 0.0,
                                    target: LatLng(50.041631, 14.443760),
                                    tilt: 0.0,
                                    zoom: 18.0),
                                attribute: 'coords',
                                decoration: InputDecoration(labelText: 'Select Location'),
                                markerIconColor: Colors.red,
                                markerIconSize: 50,
                                onChanged: (val) {
                                  print(val);
                                },
                                validators: [],
                                gestureRecognizers: {
                                  Factory<PanGestureRecognizer>(() => PanGestureRecognizer())
                                }),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: MaterialButton(
                              color: Theme.of(context).accentColor,
                              child: Text('Submit', style: TextStyle(color: Colors.white)),
                              onPressed: () async {
                                if (_fbKey.currentState.saveAndValidate()) {
                                  print(_fbKey.currentState.value);
                                  var data = _fbKey.currentState.value;
                                  data['InitialOdometer'] = int.parse(data['InitialOdometer']);
                                  data['FinalOdometer'] = int.parse(data['FinalOdometer']);
                                  data['FuelStatus'] = (data['FuelStatus'] * 100).toInt();
                                  var model = TripModel.fromJson(data);
                                  var interval = data['date_range'];
                                  model.beginDate = interval.first;
                                  model.endDate = interval.last;
                                  CameraPosition cameraPosition = data['coords'];
                                  model.latitude = cameraPosition.target.latitude;
                                  model.longitude = cameraPosition.target.longitude;
                                  print(model);
                                  BlocProvider.of<TripFormCubit>(context).createTrip(model);
                                } else {
                                  print(_fbKey.currentState.value);
                                  print('validation failed');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return LoadingIndicator();
              }),
            )));
  }
}
