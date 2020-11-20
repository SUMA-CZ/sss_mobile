import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/form_builder_validator_with_localization.dart';
import 'package:sss_mobile/core/ui/widgets/loading_indicator.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/refueling/cubit/refueling_form_cubit.dart';

class RefuelingForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final ValueChanged _onChanged = (val) => print(val);
  bool _saving = false;

  Map<String, dynamic> _initialDataFor(RefuelingFormState state) {
    if (state is RefuelingFormStateLoaded && state.refueling != null) {
      return state.refueling.toFormEditJSON();
    }
    return {
      'Date': DateTime.now(),
      'OfficialJourney': true,
      'Note': null,
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
                  // _saving = false;
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.current.failedToRefueling),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if (state is RefuelingFormStateLoading) {
                  _saving = true;
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.current.saving),
                      backgroundColor: Colors.green,
                    ),
                  );
                }

                if (state is RefuelingFormStateCreated) {
                  Navigator.of(context).pop();
                  // _saving = false;
                }
              },
              child: ModalProgressHUD(
                inAsyncCall: _saving,
                child: BlocBuilder<RefuelingFormCubit, RefuelingFormState>(
                    buildWhen: (previous, current) => current is RefuelingFormStateLoaded,
                    builder: (context, state) {
                      if (state is RefuelingFormStateLoaded) {
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
                                          FormBuilderValidatorsWithLocalization.required(),
                                          FormBuilderValidatorsWithLocalization.numeric(),
                                          FormBuilderValidatorsWithLocalization.min(1)
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
                                            FormBuilderValidatorsWithLocalization.required(),
                                            FormBuilderValidatorsWithLocalization.min(1)
                                          ],
                                          decoration: InputDecoration(labelText: S.current.litres),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                          child: FormBuilderDropdown(
                                        attribute: 'FuelType',
                                        decoration: InputDecoration(labelText: S.current.fuelType),
                                        initialValue: state.fuelTypes.first,
                                        validators: [
                                          FormBuilderValidatorsWithLocalization.required()
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
                                          FormBuilderValidatorsWithLocalization.required(),
                                          FormBuilderValidatorsWithLocalization.numeric(),
                                          FormBuilderValidatorsWithLocalization.min(1)
                                        ],
                                        keyboardType: TextInputType.number,
                                      )),
                                      SizedBox(width: 20),
                                      Expanded(
                                          child: FormBuilderDropdown(
                                        attribute: 'VatRate',
                                        decoration: InputDecoration(labelText: S.current.vat),
                                        initialValue: state.vatRates.first,
                                        validators: [
                                          FormBuilderValidatorsWithLocalization.required()
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
                                          FormBuilderValidatorsWithLocalization.required()
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
                                      if (_fbKey.currentState.saveAndValidate()) {
                                        _saveButtonAction(_fbKey.currentState.value, context);
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
              ),
            )));
  }

  void _saveButtonAction(Map<String, dynamic> data, BuildContext context) {
    BlocProvider.of<RefuelingFormCubit>(context).createRefuelingWithFormData(data);
  }
}
