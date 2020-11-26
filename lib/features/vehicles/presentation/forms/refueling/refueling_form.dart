import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:sentry/sentry.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/widgets/loading_indicator.dart';
import 'package:sss_mobile/env_config.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/refueling/cubit/refueling_form_cubit.dart';

import '../../../../../main.dart';

class RefuelingForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbRefuelingKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.addRefueling),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocListener<RefuelingFormCubit, RefuelingFormState>(
              listener: (context, state) async {
                if (state is RefuelingFormStateError) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.current.failedToRefueling),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if (state is RefuelingFormStateLoading) {
                  // TODO: Fix deprication in stable version
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.current.saving),
                      backgroundColor: Colors.green,
                    ),
                  );
                }

                if (state is RefuelingFormStateCreated) {
                  // TODO: Fix deprication in stable version
                  Scaffold.of(context).hideCurrentSnackBar();
                  await sentry.capture(
                      event: Event(
                          level: SeverityLevel.info,
                          message: 'Refueling Created',
                          environment: EnvConfig.SENTRY_ENV));
                  Navigator.of(context).pop();
                }
              },
              child: BlocBuilder<RefuelingFormCubit, RefuelingFormState>(
                  buildWhen: (previous, current) => current is RefuelingFormStateLoaded,
                  builder: (context, state) {
                    if (state is RefuelingFormStateLoaded) {
                      return ListView(
                        children: <Widget>[
                          FormBuilder(
                            // context,
                            key: _fbRefuelingKey,
                            autovalidateMode: AutovalidateMode.always,
                            readOnly: false,
                            child: Column(
                              children: <Widget>[
                                FormBuilderSwitch(
                                  label: Text(S.current.officialTrip),
                                  attribute: 'OfficialJourney',
                                  initialValue: true,
                                  activeColor: Theme.of(context).accentColor,
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
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: FormBuilderTextField(
                                      attribute: 'ReceiptNumber',
                                      decoration: InputDecoration(
                                        labelText: S.current.receiptNo,
                                      ),
                                    )),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: FormBuilderDateTimePicker(
                                        attribute: 'Date',
                                        inputType: InputType.date,
                                        initialDate: DateTime.now(),
                                        format: DateFormat.yMMMd(),
                                        validators: [
                                          FormBuilderValidators.required(
                                              errorText: S.current.validationRequired)
                                        ],
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
                                        FormBuilderValidators.required(
                                            errorText: S.current.validationRequired),
                                        FormBuilderValidators.numeric(
                                            errorText: S.current.validationNumeric),
                                        FormBuilderValidators.min(1,
                                            errorText: S.current.validationMin1)
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
                                        validators: [
                                          FormBuilderValidators.required(
                                              errorText: S.current.validationMin1),
                                          FormBuilderValidators.min(1)
                                        ],
                                        decoration: InputDecoration(labelText: S.current.litres),
                                        keyboardType: TextInputType.numberWithOptions(
                                            decimal: true, signed: false),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                        child: FormBuilderDropdown(
                                      attribute: 'FuelType',
                                      decoration: InputDecoration(labelText: S.current.fuelType),
                                      initialValue: state.fuelTypes.first,
                                      validators: [
                                        FormBuilderValidators.required(
                                            errorText: S.current.validationRequired)
                                      ],
                                      items: state.fuelTypes
                                          .map((fuelType) => DropdownMenuItem(
                                              value: fuelType, child: Text('${fuelType.name}')))
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
                                        FormBuilderValidators.required(
                                            errorText: S.current.validationRequired),
                                        FormBuilderValidators.min(1,
                                            errorText: S.current.validationMin1)
                                      ],
                                      keyboardType: TextInputType.numberWithOptions(
                                          decimal: true, signed: false),
                                    )),
                                    SizedBox(width: 20),
                                    Expanded(
                                        child: FormBuilderDropdown(
                                      attribute: 'VatRate',
                                      decoration: InputDecoration(labelText: S.current.vat),
                                      initialValue: state.vatRates.first,
                                      validators: [
                                        FormBuilderValidators.required(
                                            errorText: S.current.validationRequired)
                                      ],
                                      items: state.vatRates
                                          .map((vatRate) => DropdownMenuItem(
                                              value: vatRate, child: Text('${vatRate.vat}')))
                                          .toList(),
                                    )),
                                    SizedBox(width: 20),
                                    Expanded(
                                        child: FormBuilderDropdown(
                                      attribute: 'Currency',
                                      initialValue: state.currencies.first,
                                      decoration: InputDecoration(labelText: S.current.currency),
                                      validators: [
                                        FormBuilderValidators.required(
                                            errorText: S.current.validationRequired)
                                      ],
                                      items: state.currencies
                                          .map((gender) => DropdownMenuItem(
                                              value: gender, child: Text('${gender.code}')))
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
                                  child:
                                      Text(S.current.save, style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    if (_fbRefuelingKey.currentState.saveAndValidate()) {
                                      _saveButtonAction(
                                          _fbRefuelingKey.currentState.value, context);
                                    } else {
                                      print(_fbRefuelingKey.currentState.value);
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

  void _saveButtonAction(Map<String, dynamic> data, BuildContext context) {
    BlocProvider.of<RefuelingFormCubit>(context).createRefuelingWithFormData(data);
  }
}
