import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sss_mobile/models/maintenance.dart';
import 'package:sss_mobile/models/refueling.dart';
import 'package:sss_mobile/models/trip.dart';
import 'package:sss_mobile/models/vehicle.dart';

class VehicleDetailState extends State<VehicleDetailWidget> {

  final Vehicle vehicle;
  var _trips = <Trip>[];
  var _refuelings = <Refueling>[];
  var _maintenance = <Maintenance>[];

  VehicleDetailState(this.vehicle);


  @override
  void initState() {
    super.initState();
    _loadTrips();
    _loadMaintenances();
    _loadRefuelings();
  }

  _loadTrips() async {
    String dataUrl = "https://sss.sumanet.cz/api/vehicles/${vehicle.id}/trips";
    http.Response response = await http.get(dataUrl, headers: {"Authorization": "Bearer UbWpEOgPliravt82xF8SbMU-zKMpBM5I6LDi87QG75uAgHfWJ04Je6lcbtlz9Vrjh6LNn76-xoZldggNcREB910n7jCJKsP4U_EVJPycIm1xLIjwaEkcCWma3WFhOq6571oY29pm8QwyzUPnNKO4xcQJ9HSwP6KsmI-UGmnr0Zlp8fATXk80_KuLZBjG0zui_5eZfyJh3-Q7sIL4XcDAXEO6Fs7X9MEiwzSkGMgDZJ51EhNkc7S99vg31k1YMIu36tOcktjEgr9k_B5KG8bFMPIO44McThcH-DE7V2l1S-sz68Q17xp77rtdNjta7Zgt_BFTyA9KFVpOgTT8h5GRQfNfXJpmTP1vQGpK4JGEwBmmZvciQBlqrfwrlkd6jakba-3I-yqcisM4IxPafdbTZL7FKgQKqNAkKcBBg2Q-Y46Jbm_fg9KN7hyvIlSa9_Cj9sPV1NVYPdT5W2IFm4K0Cpy-RnQMOl-5BYAuZen9-ouv6nKyNY72yJN804SiptJjAl8O65vg2VXdvAilyr-Ht6b4onCAQILZelb47b2qbAnsETLXrQuYxC-kEOLglLsA_iE3nGGXJQUpS5gl_ozzCEt7IknBUZTcRFPrS79jChhCvt0LGPrHPuj9MzHiN3SEOlEvlwjqM7phQxAvVck5It4FwS40jhtAxGCaZrvi52WaesKJVFwpemnYvxAWn3m4eGpunj3yglLHUawKhTBU_MS6Fm8lsqvRO7Dn9uvag_EUW1iyOempfkqpyY3m71pd8XFR7m6Mo00ZGgiuyhZ5nk5uSncNtVu_HAhPhR74GyHtFXX72i-Ow1le7LSymLmpGm87UdqlnNFeHFIpLABb-Mrl79VXNpxYxIMKEvmHmt87y85JYd0uRaj7C76KokseXHe8gyABAfMIBzVAMpBSkbXAr3GJsjPuFMZqj0Co3lbXpCLm9K8_Yz_FwTw77xkfTi8I35f06-fFnm-O20VS0pTb-RadxptIIl3KNnPt2jLnbxNEouIHzUAHZeoHSxrMO-KD18NceDBQ7jkrSreEZM86KF7GooWr0kqnBCraQQ8Lbhqp8_b1__ZqZDlYaounS5svghmOZT0St8JKeVOuXlhLmAg7tncTK1bGn14M20z4jrxccUL-frr50mCxpCwZjLbuyKta3gN4qUkujhCkGLXkNxgYHIqzPwK9grNs4nmjUSmr90NrSUy0C4odMsR1VtWlImsmaqTKcXVzAYm4U1xgZ50RSsXZgMbKY9kz4OZNxjXzI5NWhfKde-UvmoCBCuYIInNQMl6lDyIldbS1aDKOLQlKfjuDcQQoS8AEufssOBav0fRJdnIustjaildO2appqf_ZlJTnCisGa8aKEMfGrbTuI6Drfik_1I2JZr_u1gJgWxChF3aNOTqYgUsMECSFLfLWs1AzzHqf60TeYG3Kz_OBai9A942npaHrs-EfX9O48ryFqoeK0voJC0o9"});
    setState(() {
      final json = jsonDecode(response.body);
      for (var j in json) {
        _trips.add(Trip.fromJson(j));
      }
    });
  }

  _loadRefuelings() async {
    String dataUrl = "https://sss.sumanet.cz/api/vehicles/${vehicle.id}/refuelings";
    http.Response response = await http.get(dataUrl, headers: {"Authorization": "Bearer UbWpEOgPliravt82xF8SbMU-zKMpBM5I6LDi87QG75uAgHfWJ04Je6lcbtlz9Vrjh6LNn76-xoZldggNcREB910n7jCJKsP4U_EVJPycIm1xLIjwaEkcCWma3WFhOq6571oY29pm8QwyzUPnNKO4xcQJ9HSwP6KsmI-UGmnr0Zlp8fATXk80_KuLZBjG0zui_5eZfyJh3-Q7sIL4XcDAXEO6Fs7X9MEiwzSkGMgDZJ51EhNkc7S99vg31k1YMIu36tOcktjEgr9k_B5KG8bFMPIO44McThcH-DE7V2l1S-sz68Q17xp77rtdNjta7Zgt_BFTyA9KFVpOgTT8h5GRQfNfXJpmTP1vQGpK4JGEwBmmZvciQBlqrfwrlkd6jakba-3I-yqcisM4IxPafdbTZL7FKgQKqNAkKcBBg2Q-Y46Jbm_fg9KN7hyvIlSa9_Cj9sPV1NVYPdT5W2IFm4K0Cpy-RnQMOl-5BYAuZen9-ouv6nKyNY72yJN804SiptJjAl8O65vg2VXdvAilyr-Ht6b4onCAQILZelb47b2qbAnsETLXrQuYxC-kEOLglLsA_iE3nGGXJQUpS5gl_ozzCEt7IknBUZTcRFPrS79jChhCvt0LGPrHPuj9MzHiN3SEOlEvlwjqM7phQxAvVck5It4FwS40jhtAxGCaZrvi52WaesKJVFwpemnYvxAWn3m4eGpunj3yglLHUawKhTBU_MS6Fm8lsqvRO7Dn9uvag_EUW1iyOempfkqpyY3m71pd8XFR7m6Mo00ZGgiuyhZ5nk5uSncNtVu_HAhPhR74GyHtFXX72i-Ow1le7LSymLmpGm87UdqlnNFeHFIpLABb-Mrl79VXNpxYxIMKEvmHmt87y85JYd0uRaj7C76KokseXHe8gyABAfMIBzVAMpBSkbXAr3GJsjPuFMZqj0Co3lbXpCLm9K8_Yz_FwTw77xkfTi8I35f06-fFnm-O20VS0pTb-RadxptIIl3KNnPt2jLnbxNEouIHzUAHZeoHSxrMO-KD18NceDBQ7jkrSreEZM86KF7GooWr0kqnBCraQQ8Lbhqp8_b1__ZqZDlYaounS5svghmOZT0St8JKeVOuXlhLmAg7tncTK1bGn14M20z4jrxccUL-frr50mCxpCwZjLbuyKta3gN4qUkujhCkGLXkNxgYHIqzPwK9grNs4nmjUSmr90NrSUy0C4odMsR1VtWlImsmaqTKcXVzAYm4U1xgZ50RSsXZgMbKY9kz4OZNxjXzI5NWhfKde-UvmoCBCuYIInNQMl6lDyIldbS1aDKOLQlKfjuDcQQoS8AEufssOBav0fRJdnIustjaildO2appqf_ZlJTnCisGa8aKEMfGrbTuI6Drfik_1I2JZr_u1gJgWxChF3aNOTqYgUsMECSFLfLWs1AzzHqf60TeYG3Kz_OBai9A942npaHrs-EfX9O48ryFqoeK0voJC0o9"});
    setState(() {
      final json = jsonDecode(response.body);
      for (var j in json) {
        _refuelings.add(Refueling.fromJson(j));
      }
    });
  }

  _loadMaintenances() async {
    String dataUrl = "https://sss.sumanet.cz/api/vehicles/${vehicle.id}/maintenances";
    http.Response response = await http.get(dataUrl, headers: {"Authorization": "Bearer UbWpEOgPliravt82xF8SbMU-zKMpBM5I6LDi87QG75uAgHfWJ04Je6lcbtlz9Vrjh6LNn76-xoZldggNcREB910n7jCJKsP4U_EVJPycIm1xLIjwaEkcCWma3WFhOq6571oY29pm8QwyzUPnNKO4xcQJ9HSwP6KsmI-UGmnr0Zlp8fATXk80_KuLZBjG0zui_5eZfyJh3-Q7sIL4XcDAXEO6Fs7X9MEiwzSkGMgDZJ51EhNkc7S99vg31k1YMIu36tOcktjEgr9k_B5KG8bFMPIO44McThcH-DE7V2l1S-sz68Q17xp77rtdNjta7Zgt_BFTyA9KFVpOgTT8h5GRQfNfXJpmTP1vQGpK4JGEwBmmZvciQBlqrfwrlkd6jakba-3I-yqcisM4IxPafdbTZL7FKgQKqNAkKcBBg2Q-Y46Jbm_fg9KN7hyvIlSa9_Cj9sPV1NVYPdT5W2IFm4K0Cpy-RnQMOl-5BYAuZen9-ouv6nKyNY72yJN804SiptJjAl8O65vg2VXdvAilyr-Ht6b4onCAQILZelb47b2qbAnsETLXrQuYxC-kEOLglLsA_iE3nGGXJQUpS5gl_ozzCEt7IknBUZTcRFPrS79jChhCvt0LGPrHPuj9MzHiN3SEOlEvlwjqM7phQxAvVck5It4FwS40jhtAxGCaZrvi52WaesKJVFwpemnYvxAWn3m4eGpunj3yglLHUawKhTBU_MS6Fm8lsqvRO7Dn9uvag_EUW1iyOempfkqpyY3m71pd8XFR7m6Mo00ZGgiuyhZ5nk5uSncNtVu_HAhPhR74GyHtFXX72i-Ow1le7LSymLmpGm87UdqlnNFeHFIpLABb-Mrl79VXNpxYxIMKEvmHmt87y85JYd0uRaj7C76KokseXHe8gyABAfMIBzVAMpBSkbXAr3GJsjPuFMZqj0Co3lbXpCLm9K8_Yz_FwTw77xkfTi8I35f06-fFnm-O20VS0pTb-RadxptIIl3KNnPt2jLnbxNEouIHzUAHZeoHSxrMO-KD18NceDBQ7jkrSreEZM86KF7GooWr0kqnBCraQQ8Lbhqp8_b1__ZqZDlYaounS5svghmOZT0St8JKeVOuXlhLmAg7tncTK1bGn14M20z4jrxccUL-frr50mCxpCwZjLbuyKta3gN4qUkujhCkGLXkNxgYHIqzPwK9grNs4nmjUSmr90NrSUy0C4odMsR1VtWlImsmaqTKcXVzAYm4U1xgZ50RSsXZgMbKY9kz4OZNxjXzI5NWhfKde-UvmoCBCuYIInNQMl6lDyIldbS1aDKOLQlKfjuDcQQoS8AEufssOBav0fRJdnIustjaildO2appqf_ZlJTnCisGa8aKEMfGrbTuI6Drfik_1I2JZr_u1gJgWxChF3aNOTqYgUsMECSFLfLWs1AzzHqf60TeYG3Kz_OBai9A942npaHrs-EfX9O48ryFqoeK0voJC0o9"});
    setState(() {
      final json = jsonDecode(response.body);
      for (var j in json) {
        _maintenance.add(Maintenance.fromJson(j));
      }
    });
  }

  Widget _buildRowForTrip(int i) {
    return new ListTile(
      subtitle: new Text("${_trips[i].id}"),
      title: new Text("${_trips[i].beginOdometer} - ${_trips[i].endOdometer}"),
    );
  }

  Widget _buildRowForMaintenance(int i) {
    return new ListTile(
      subtitle: new Text("${_maintenance[i].user.name}"),
      title: new Text("${_maintenance[i].state} - ${_maintenance[i].note}"),
    );
  }

  Widget _buildRowForRefueling(int i) {
    return new ListTile(
      subtitle: new Text("${_refuelings[i].user.name}"),
      title: new Text("${_refuelings[i].odometer} km - ${_refuelings[i].fuelAmount} litres"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.local_dining)),
                Tab(icon: Icon(Icons.build)),
              ],
            ),
            title: Text(vehicle.name),
          ),
          body: TabBarView(
            children: [
              new ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _trips.length,
                  itemBuilder: (BuildContext context, int position) {
                    return _buildRowForTrip(position);
                  }),
              new ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _refuelings.length,
                  itemBuilder: (BuildContext context, int position) {
                    return _buildRowForRefueling(position);
                  }),
              new ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _maintenance.length,
                  itemBuilder: (BuildContext context, int position) {
                    return _buildRowForMaintenance(position);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class VehicleDetailWidget extends StatefulWidget {
  final Vehicle vehicle;


  VehicleDetailWidget(this.vehicle);

  @override
  createState() => new VehicleDetailState(vehicle);
}
