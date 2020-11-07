import 'package:flutter/cupertino.dart';

class UserCredentials {
  String username = '';
  String password = '';

  UserCredentials({@required this.username, @required this.password})
      : assert(username != null, password != null);
}
