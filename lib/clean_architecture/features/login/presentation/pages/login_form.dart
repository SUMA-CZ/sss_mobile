// home_material.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _usernameController.text = 'tomas.sykora@ajty.cz';
    _passwordController.text = 'Hawk2772';

    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Přihlašovací email'),
                    controller: _usernameController,
                    validator: (value) {
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Neplatný email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                      decoration: InputDecoration(labelText: 'Heslo'),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Prazdné heslo';
                        }
                        return null;
                      }),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        state is! LoginLoading ? _onLoginButtonPressed() : null;
                      }
                    },
                    child:
                        state is LoginLoading ? CircularProgressIndicator() : Text('Přihlásit se'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
