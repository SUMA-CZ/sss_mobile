import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/authorization/auth.dart';
import 'package:sss_mobile/features/login/domain/repositories/user_repository.dart';
import 'package:sss_mobile/injection_container.dart';

class AuthorizationInterceptor extends Interceptor {
  UserRepository repo;

  AuthorizationInterceptor({@required this.repo});

  @override
  Future onRequest(RequestOptions options) async {
    repo.accessToken().fold((l) {
      print('No Token');
    }, (r) {
      options.headers["Authorization"] = 'Bearer $r';
    });

    return options;
  }

  @override
  Future onError(DioError err) async {
    if (err.response.statusCode == 401) {
      debugPrint('HTTP 401: ${err.request.uri}');
      sl<AuthenticationBloc>().add(LoggedOut());
    }

    return err;
  }
}
