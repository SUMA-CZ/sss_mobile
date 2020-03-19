
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sss_mobile/string.dart';
import 'package:http/http.dart' as http;
import 'package:sss_mobile/models/vehicle.dart';
import 'package:sss_mobile/screens/vehicle_detail_screen.dart';

class VehicleListScreenState extends State<VehicleListScreen> {
  var _vehicles = <Vehicle>[];
  // TODO: Fill in all the data
  final _companySPZ = ["5A54291", "1AC8423", "2AM7900", "6AB7175", "6AD2452", "6AE2712", "5A48356"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new AppBar(
            title: new Text(Strings.appTitle),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.domain), text: "Company Vehicles"),
                Tab(icon: Icon(Icons.person), text: "Personal Vehicles")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              new ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _vehicles.where((v) => _companySPZ.contains(v.spz)).length,
                  itemBuilder: (BuildContext context, int position) {
                    return _buildCompanyVehicleRow(position);
                  }),
              new ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _vehicles.length,
                  itemBuilder: (BuildContext context, int position) {
                    return _buildPersonalVehicleRow(position);
                  }),
            ],
          ),
        )
    ),);
  }

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Widget _buildCompanyVehicleRow(int i) {
    var filtered = _vehicles.where((v) => _companySPZ.contains(v.spz)).toList();
    return _buildRow(i, filtered);
  }

  Widget _buildPersonalVehicleRow(int i) {
    var filtered = _vehicles.where((v) => !_companySPZ.contains(v.spz)).toList();
    return _buildRow(i, filtered);
  }

  Widget _buildRow(int i, List<Vehicle> data) {
    return new ListTile(
        subtitle: new Text("${data[i].spz}"),
        title: new Text("${data[i].name}"),
      onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleDetailScreen(data[i])));
      },
    );
  }

  _loadVehicles() async {
    String dataUrl = "https://sss.sumanet.cz/api/vehicles";
    http.Response response = await http.get(dataUrl, headers: {"Authorization": "Bearer UbWpEOgPliravt82xF8SbMU-zKMpBM5I6LDi87QG75uAgHfWJ04Je6lcbtlz9Vrjh6LNn76-xoZldggNcREB910n7jCJKsP4U_EVJPycIm1xLIjwaEkcCWma3WFhOq6571oY29pm8QwyzUPnNKO4xcQJ9HSwP6KsmI-UGmnr0Zlp8fATXk80_KuLZBjG0zui_5eZfyJh3-Q7sIL4XcDAXEO6Fs7X9MEiwzSkGMgDZJ51EhNkc7S99vg31k1YMIu36tOcktjEgr9k_B5KG8bFMPIO44McThcH-DE7V2l1S-sz68Q17xp77rtdNjta7Zgt_BFTyA9KFVpOgTT8h5GRQfNfXJpmTP1vQGpK4JGEwBmmZvciQBlqrfwrlkd6jakba-3I-yqcisM4IxPafdbTZL7FKgQKqNAkKcBBg2Q-Y46Jbm_fg9KN7hyvIlSa9_Cj9sPV1NVYPdT5W2IFm4K0Cpy-RnQMOl-5BYAuZen9-ouv6nKyNY72yJN804SiptJjAl8O65vg2VXdvAilyr-Ht6b4onCAQILZelb47b2qbAnsETLXrQuYxC-kEOLglLsA_iE3nGGXJQUpS5gl_ozzCEt7IknBUZTcRFPrS79jChhCvt0LGPrHPuj9MzHiN3SEOlEvlwjqM7phQxAvVck5It4FwS40jhtAxGCaZrvi52WaesKJVFwpemnYvxAWn3m4eGpunj3yglLHUawKhTBU_MS6Fm8lsqvRO7Dn9uvag_EUW1iyOempfkqpyY3m71pd8XFR7m6Mo00ZGgiuyhZ5nk5uSncNtVu_HAhPhR74GyHtFXX72i-Ow1le7LSymLmpGm87UdqlnNFeHFIpLABb-Mrl79VXNpxYxIMKEvmHmt87y85JYd0uRaj7C76KokseXHe8gyABAfMIBzVAMpBSkbXAr3GJsjPuFMZqj0Co3lbXpCLm9K8_Yz_FwTw77xkfTi8I35f06-fFnm-O20VS0pTb-RadxptIIl3KNnPt2jLnbxNEouIHzUAHZeoHSxrMO-KD18NceDBQ7jkrSreEZM86KF7GooWr0kqnBCraQQ8Lbhqp8_b1__ZqZDlYaounS5svghmOZT0St8JKeVOuXlhLmAg7tncTK1bGn14M20z4jrxccUL-frr50mCxpCwZjLbuyKta3gN4qUkujhCkGLXkNxgYHIqzPwK9grNs4nmjUSmr90NrSUy0C4odMsR1VtWlImsmaqTKcXVzAYm4U1xgZ50RSsXZgMbKY9kz4OZNxjXzI5NWhfKde-UvmoCBCuYIInNQMl6lDyIldbS1aDKOLQlKfjuDcQQoS8AEufssOBav0fRJdnIustjaildO2appqf_ZlJTnCisGa8aKEMfGrbTuI6Drfik_1I2JZr_u1gJgWxChF3aNOTqYgUsMECSFLfLWs1AzzHqf60TeYG3Kz_OBai9A942npaHrs-EfX9O48ryFqoeK0voJC0o9"});
    setState(() {
      final vehiclesJSON = jsonDecode(response.body);
      for (var vehicleJSON in vehiclesJSON) {
        _vehicles.add(Vehicle.fromJson(vehicleJSON));
      }
    });
  }

}

class VehicleListScreen extends StatefulWidget {
  @override
  createState() => new VehicleListScreenState();
}