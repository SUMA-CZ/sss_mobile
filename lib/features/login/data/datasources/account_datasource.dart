import 'dart:async';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/error/exception.dart';
import 'package:sss_mobile/features/login/data/models/token_model.dart';
import 'package:sss_mobile/features/login/data/models/user_credentitials_model.dart';

import '../../../../env_config.dart';

abstract class AccountDataSource {
  Future<TokenModel> authenticate(UserCredentialsModel credentials);
}

class AccountDataSourceImpl implements AccountDataSource {
  final Dio client;

  AccountDataSourceImpl({@required this.client}) : assert(client != null);

  @override
  Future<TokenModel> authenticate(UserCredentialsModel credentials) {
    return _authenticate('${EnvConfig.API_URL}/Account/Login', credentials.toJson());
  }

  Future<TokenModel> _authenticate(String url, Map<String, dynamic> payload) async {
    try {
      final response = await client.post(url, data: payload);
      return TokenModel.fromJson(response.data);
    } catch (e) {
      throw ServerException();
    }
  }
}
