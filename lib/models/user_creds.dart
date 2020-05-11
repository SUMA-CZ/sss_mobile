class UserCreds {
  String username = '';
  String password = '';

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Username': username,
        'Password': password,
      };

  save() {
    print('saving user using a web service');
  }
}
