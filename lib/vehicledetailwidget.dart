
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sss_mobile/string.dart';
import 'package:http/http.dart' as http;
import 'package:sss_mobile/vehicle.dart';

class VehicleDetailState extends State<VehicleDetailWidget> {
  var _vehicle = Vehicle();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text(
                Strings.appTitle)),
        body: new Text(_vehicle.name)
    );
  }

}

class VehicleDetailWidget extends StatefulWidget {

  @override
  createState() => new VehicleDetailState();
}


class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Vehicle vehicle;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(vehicle.spz),
      ),
    );
  }
}