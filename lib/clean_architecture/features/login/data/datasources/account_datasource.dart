import 'dart:async';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/clean_architecture/core/error/exception.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/models/e_token_model.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/models/e_user_credentitials_model.dart';

abstract class AccountDataSource {
  Future<ETokenModel> authenticate(EUserCredentialsModel credentials);
}

class AccountDataSourceImpl implements AccountDataSource {
  final Dio client;

  AccountDataSourceImpl({@required this.client}) : assert(client != null);

  @override
  Future<ETokenModel> authenticate(EUserCredentialsModel credentials) {
    return _authenticate('https://sss.suma.guru/api/Account/Login', credentials.toJson());
  }

  Future<ETokenModel> _authenticate(String url, Map<String, dynamic> payload) async {
    try {
      final response = await client.post(url, data: payload);
      return ETokenModel.fromJson(response.data);
    } catch (e) {
      throw ServerException();
    }
  }
}
