
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sss_mobile/string.dart';
import 'package:http/http.dart' as http;
import 'package:sss_mobile/vehicle.dart';

class SSSState extends State<CarsListWidget> {
  var _vehicles = <Vehicle>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
              Strings.appTitle)),
      body: new ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _vehicles.length,
          itemBuilder: (BuildContext context, int position) {
        return _buildRow(position);
      })
    );
  }

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Widget _buildRow(int i) {
    return new ListTile(
        subtitle: new Text("${_vehicles[i].spz}"),
        title: new Text("${_vehicles[i].name}")
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

class CarsListWidget extends StatefulWidget {
  @override
  createState() => new SSSState();
}