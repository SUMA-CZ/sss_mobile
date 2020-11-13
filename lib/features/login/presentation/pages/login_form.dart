import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/widgets/loading_indicator.dart';

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
          if (state is LoginLoading) {
            return LoadingIndicator();
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: S.current.loginEmail),
                    controller: _usernameController,
                    validator: (value) {
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return S.current.loginEmailInvalid;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                      decoration: InputDecoration(labelText: S.current.loginPassword),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return S.current.loginPasswordIsEmpty;
                        }
                        return null;
                      }),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        if (state is! LoginLoading) {
                          _onLoginButtonPressed();
                        }
                      }
                    },
                    child: Text(S.current.loginButton),
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
