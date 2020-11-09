import 'package:meta/meta.dart';
import 'package:sss_mobile/features/login/domain/entities/user_credentials.dart';

class UserCredentialsModel extends UserCredentials {
  UserCredentialsModel({@required String username, @required String password})
      : super(username: username, password: password);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Username': username,
        'Password': password,
      };
}
