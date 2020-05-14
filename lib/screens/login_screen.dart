// home_material.dart
import 'package:flutter/material.dart';
import 'package:sss_mobile/models/user_creds.dart';
import 'package:sss_mobile/networking/login_api.dart';
import 'package:sss_mobile/screens/vehicle_list_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State {
  final _formKey = GlobalKey<FormState>();
  final _userCreds = UserCreds();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Kniha jízd')),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            initialValue: "tomas.sykora@ajty.cz",
                            decoration: InputDecoration(labelText: 'Email'),
                            validator: (value) {
                              if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return 'Neplatný email';
                              }
                              return null;
                            },
                            onSaved: (val) =>
                                setState(() => _userCreds.username = val),
                          ),
                          TextFormField(
                              initialValue: "Hawk2772",
                              obscureText: true,
                              decoration: InputDecoration(labelText: 'Heslo'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Prazdné heslo';
                                }
                                return null;
                              },
                              onSaved: (val) =>
                                  setState(() => _userCreds.password = val)),
                          RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('Logging in...')));
                                  LoginAPI()
                                      .login(_userCreds)
                                      .then((value) =>
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VehicleListScreen()))
                                  })
                                      .catchError((error) =>
                                  {
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(content: Text(error)))
                                  });
                                }
                              },
                              child: Text('Přihlásit se'))
                        ])))));
  }
}
