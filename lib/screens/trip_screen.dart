import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sss_mobile/models/trip.dart';

class TripScreen extends StatefulWidget {
  final Trip trip;

  TripScreen({Key key, this.trip}) : super(key: key);

  @override
  _TripScreenState createState() => _TripScreenState(trip);
}

class _TripScreenState extends State<TripScreen> {
  final _formKey = GlobalKey();

  final Trip trip;

  _TripScreenState(this.trip);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: trip != null ? Text('Upravit jízdu') : Text('Nová jízda')),
        body: Container(
            child: Builder(
                builder: (context) => Form(
                      key: _formKey,
                      child: Container(),
                    ))));
  }
}
