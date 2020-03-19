import 'package:flutter/material.dart';
import 'package:sss_mobile/screens/vehicle_list_screen.dart';
import 'string.dart';

void main() => runApp(SSSApp());

class SSSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Strings.appTitle,
      home: new VehicleListScreen()
    );
  }
  
}