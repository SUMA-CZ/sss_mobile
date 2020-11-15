import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/widgets/loading_indicator.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/refueling/cubit/refueling_form_cubit.dart';

class RefuelingForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final ValueChanged _onChanged = (val) => print(val);

  Map<String, dynamic> _initialDataFor(RefuelingFormState state) {
    if (state is RefuelingFormStateLoaded) {
      return state.refueling.toFormEditJSON();
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
            child: BlocListener<RefuelingFormCubit, RefuelingFormState>(
              listener: (context, state) {
                if (state is RefuelingFormStateError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.current.failedToSaveTrip),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if (state is RefuelingFormStateCreated) {
                  Navigator.of(context).pop();
                }
              },
              child: BlocBuilder<RefuelingFormCubit, RefuelingFormState>(builder: (context, state) {
                if (state is RefuelingFormStateInitial || state is RefuelingFormStateLoaded) {
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
                            FormBuilderImagePicker(
                              attribute: 'images',
                              decoration: const InputDecoration(
                                labelText: 'Images',
                              ),
                              defaultImage: NetworkImage(
                                  'https://cohenwoodworking.com/wp-content/uploads/2016/09/image-placeholder-500x500.jpg'),
                              maxImages: 1,
                              iconColor: Colors.red,
                              // readOnly: true,
                              // validators: [
                              //   FormBuilderValidators.required(),
                              //   (images) {
                              //     if (images.length < 2) {
                              //       return 'Two or more images required.';
                              //     }
                              //     return null;
                              //   }
                              // ],
                              onChanged: _onChanged,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: FormBuilderTextField(
                                  initialValue: '',
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
                                  initialValue: '',
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
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              // color: Theme.of(context).accentColor,
                              child: Text(S.current.save, style: TextStyle(color: Colors.white)),
                              onPressed: () async {
                                if (_fbKey.currentState.saveAndValidate()) {
                                  // print(_fbKey.currentState.value);
                                  // var data = _fbKey.currentState.value;
                                  // data['InitialOdometer'] = int.parse(data['InitialOdometer']);
                                  // data['FinalOdometer'] = int.parse(data['FinalOdometer']);
                                  // data['FuelStatus'] = (data['FuelStatus'] * 100).toInt();
                                  // var model = TripModel.fromJson(data);
                                  // var interval = data['date_range'];
                                  // model.beginDate = interval.first;
                                  // model.endDate = interval.last;
                                  // CameraPosition cameraPosition = data['coords'];
                                  // model.latitude = cameraPosition.target.latitude;
                                  // model.longitude = cameraPosition.target.longitude;
                                  // print(model);
                                  // BlocProvider.of<TripFormCubit>(context).createTrip(model);
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
