// home_material.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class UserCreds {
  String username = '';
  String password = '';

  save() {
    print('saving user using a web service');
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State {
  final _formKey = GlobalKey<FormState>();
  final _user = UserCreds();

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
                                setState(() => _user.username = val),
                          ),
                          TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(labelText: 'Heslo'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Prazdné heslo';
                                }
                                return null;
                              },
                              onSaved: (val) =>
                                  setState(() => _user.password = val)),
                          RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.



                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text(_user.username)));
                                }
                              },
                              child: Text('Přihlásit se'))
                        ])))));
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
