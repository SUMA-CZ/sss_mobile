import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';

class FormBuilderValidatorsWithLocalization {
  static FormFieldValidator required() {
    return FormBuilderValidators.required(errorText: S.current.validationRequired);
  }

  static FormFieldValidator numeric() {
    return FormBuilderValidators.numeric(errorText: S.current.validationNumeric);
  }

  static FormFieldValidator min(num value) {
    return FormBuilderValidators.min(value, errorText: S.current.validationMin1);
  }
}
