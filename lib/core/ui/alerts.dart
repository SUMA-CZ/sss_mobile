import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';

void showDeleteAlertDialog(BuildContext context, Function f) {
  Widget cancelButton = FlatButton(
    child: Text(S.current.keep),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text(S.current.delete),
    color: Colors.red,
    onPressed: () {
      f.call();

      Navigator.of(context).pop();
    },
  );
  var alert = AlertDialog(
    title: Text(S.current.delete),
    content: Text(S.current.deleteRecord),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
