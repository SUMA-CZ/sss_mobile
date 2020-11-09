import 'package:flutter/material.dart';

class VehicleDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Vehicle Detail'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.domain), text: "Trips"),
                Tab(icon: Icon(Icons.person), text: "Refuelings"),
                Tab(icon: Icon(Icons.person), text: "Maintenances")
              ],
            ),
          ),
          body: Container(),
        ));
  }
}
