import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/features/login/domain/repositories/user_repository.dart';

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
}
