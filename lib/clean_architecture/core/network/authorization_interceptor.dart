import 'package:http_interceptor/http_interceptor.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/clean_architecture/features/login/domain/repositories/user_repository.dart';

class AuthorizationInterceptor implements InterceptorContract {
  UserRepository userRepository;

  AuthorizationInterceptor({@required this.userRepository}) : assert(userRepository != null);

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('${data.method} => ${data.url}');
    try {
      userRepository.accessToken().fold((l) {
        throw Exception('No Token ');
      }, (r) {
        data.headers["Authorization"] = 'Bearer $r';
      });
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async => data;
}
