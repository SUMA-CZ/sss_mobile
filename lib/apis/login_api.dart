import 'dart:convert';

import 'package:http/http.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/models/e_user_credentitials_model.dart';
import 'package:sss_mobile/models/token.dart';

import '../clean_architecture/core/env.dart';

class LoginAPI {
  Client client = Client();

  Future<Token> login(EUserCredentialsModel creds) async {
    var token = Token();
    try {
      final response =
          await client.post("${environment['baseUrl']}/Account/Login", body: creds.toJson());
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        token = Token.fromJson(json);
      } else {
        throw Exception("Error while fetching. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return token;
  }
}
