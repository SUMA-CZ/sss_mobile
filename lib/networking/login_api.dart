import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss_mobile/models/token.dart';
import 'package:sss_mobile/models/user_creds.dart';

import 'env.dart';

class LoginAPI {
  Client client = Client();

  Future<Token> login(UserCreds creds) async {
    var token = Token();
    try {
      final response = await client.post(
          "${environment['baseUrl']}/Account/Login", body: creds.toJson());
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        token = Token.fromJson(json);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token.accessToken);
      } else {
        throw Exception("Error while fetching. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return token;
  }
}