import 'package:flutter/widgets.dart';

TableRow buildTableRowWithPadding(String left, String right) {
  return TableRow(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(left),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(right),
    )
  ]);
}
