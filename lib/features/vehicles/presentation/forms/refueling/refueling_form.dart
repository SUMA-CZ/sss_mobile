import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/widgets/loading_indicator.dart';
import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/refueling/cubit/refueling_form_cubit.dart';

class RefuelingForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final ValueChanged _onChanged = (val) => print(val);

  Map<String, dynamic> _initialDataFor(RefuelingFormState state) {
    if (state is RefuelingFormStateLoaded) {
      return state.refueling.toFormEditJSON();
    }
    return {
      'Date': DateTime.now(),
      'OdometerState': '0',
      'PriceIncludingVAT': '0',
      'FuelBulk': '0',
      'OfficialJourney': true,
      'Note': null,
      'VatRate': '21%',
      'Currency': 'CZK',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.addRefueling),
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
                              onChanged: _onChanged,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: FormBuilderDateTimePicker(
                                    attribute: 'Date',
                                    inputType: InputType.date,
                                    format: DateFormat.yMMMd(),
                                    decoration: InputDecoration(labelText: S.current.date),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                    child: FormBuilderTextField(
                                  attribute: 'OdometerState',
                                  decoration: InputDecoration(
                                    labelText: S.current.odometer,
                                  ),
                                  validators: [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                  ],
                                  keyboardType: TextInputType.number,
                                )),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: FormBuilderTextField(
                                    attribute: 'FuelBulk',
                                    decoration: InputDecoration(labelText: S.current.litres),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                    child: FormBuilderDropdown(
                                  attribute: "FuelType",
                                  decoration: InputDecoration(labelText: S.current.fuelType),
                                  initialValue: 'Male',
                                  // hint: Text('Select Gender'),
                                  validators: [FormBuilderValidators.required()],
                                  items: ['Male', 'Female', 'Other']
                                      .map((gender) =>
                                          DropdownMenuItem(value: gender, child: Text("$gender")))
                                      .toList(),
                                )),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: FormBuilderTextField(
                                  attribute: 'PriceIncludingVAT',
                                  decoration: InputDecoration(
                                    labelText: S.current.price,
                                  ),
                                  validators: [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                  ],
                                  keyboardType: TextInputType.number,
                                )),
                                SizedBox(width: 20),
                                Expanded(
                                    child: FormBuilderDropdown(
                                  attribute: "gender",
                                  decoration: InputDecoration(labelText: S.current.vat),
                                  initialValue: '21%',
                                  // hint: Text('Select Gender'),
                                  validators: [FormBuilderValidators.required()],
                                  items: ['21%', 'Female', 'Other']
                                      .map((gender) =>
                                          DropdownMenuItem(value: gender, child: Text("$gender")))
                                      .toList(),
                                )),
                                SizedBox(width: 20),
                                Expanded(
                                    child: FormBuilderDropdown(
                                  attribute: "Currency",
                                  initialValue: 'CZK',
                                  decoration: InputDecoration(labelText: S.current.currency),
                                  validators: [FormBuilderValidators.required()],
                                  items: ['CZK', 'EUR']
                                      .map((gender) =>
                                          DropdownMenuItem(value: gender, child: Text("$gender")))
                                      .toList(),
                                )),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: FormBuilderTextField(
                                  initialValue: '',
                                  attribute: 'Note',
                                  decoration: InputDecoration(
                                    labelText: S.current.note,
                                  ),
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
                                  // body: JSON.stringify({
                                  //   Date: Moment(date).format('YYYY-MM-DD'),
                                  //   OdometerState: odometerState,
                                  //   OfficialJourney: officialJourney,
                                  //   Note: note,
                                  //   FuelBulk: fuelBulk,
                                  //   PriceIncludingVAT: priceIncludingVAT,
                                  //   ReceiptNumber: receiptNumber,
                                  //   CurrencyId: currency,
                                  //   FuelTypeId: fuelType,
                                  //   VatRateId: vatRate,
                                  //   Scan: 'data:image/png;base64,' + base64Image
                                  // })
                                  var data = _fbKey.currentState.value;
                                  var model = RefuelingModel();
                                  model.date = data['Date'];
                                  model.odometer = int.parse(data['OdometerState']);
                                  model.price = double.parse(data['PriceIncludingVAT']);
                                  model.official = data['OfficialJourney'];
                                  model.note = data['Note'];
                                  model.fuelAmount = double.parse(data['FuelBulk']);

                                  BlocProvider.of<RefuelingFormCubit>(context)
                                      .createRefueling(model);
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
