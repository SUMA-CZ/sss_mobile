import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/models/e_token_model.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/models/e_user_credentitials_model.dart';

abstract class AccountDataSource {
  Future<ETokenModel> authenticate(EUserCredentialsModel credentials);
}

class AccountDataSourceImpl implements AccountDataSource {
  final http.Client client;

  AccountDataSourceImpl({@required this.client}) : assert(client != null);

  @override
  Future<ETokenModel> authenticate(EUserCredentialsModel credentials) {
    return _authenticate('https://sss.suma.guru/api/Account/Login', credentials.toJson());
  }

  Future<ETokenModel> _authenticate(String url, Map<String, dynamic> payload) async {
    final response = await client.post(url, body: payload);
    if (response.statusCode == 200) {
      return ETokenModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
