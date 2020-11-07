import 'package:meta/meta.dart';
import 'package:sss_mobile/clean_architecture/features/login/domain/entities/e_user_credentials.dart';

class EUserCredentialsModel extends UserCredentials {
  EUserCredentialsModel({@required String username, @required String password})
      : super(username: username, password: password);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Username': username,
        'Password': password,
      };
}
