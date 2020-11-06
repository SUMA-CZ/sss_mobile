import 'package:http_interceptor/http_interceptor.dart';
import 'package:sss_mobile/repositories/user_repo.dart';

class AuthorizationInterceptor implements InterceptorContract {
  UserRepository userRepository;

  AuthorizationInterceptor({this.userRepository});

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    try {
      data.headers["Authorization"] = await userRepository.accessToken();
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async => data;
}
