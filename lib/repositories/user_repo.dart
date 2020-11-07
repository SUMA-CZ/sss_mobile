import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss_mobile/apis/login_api.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/models/e_user_credentitials_model.dart';
import 'package:sss_mobile/models/token.dart';

class UserRepository {
  static const KEY = 'TOKEN';

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    Token token =
        await LoginAPI().login(EUserCredentialsModel(username: username, password: password));
    return token.accessToken;
  }

  Future<void> persistToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY, token);
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY, null);
  }

  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString(KEY));
    return token != null;
  }

  Future<String> accessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString(KEY) ?? "");
    return token;
  }
}
