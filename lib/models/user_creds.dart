class UserCreds {
  String username = '';
  String password = '';

  UserCreds(this.username, this.password);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Username': username,
        'Password': password,
      };

  save() {
    print('saving user using a web service');
  }
}
