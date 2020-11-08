import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sss_mobile/features/login/domain/repositories/user_repository.dart';

import '../../../../injection_container.dart' as di;
import '../bloc/login_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SSS Přihlášení'),
      ),
      body: BlocProvider(
        create: (context) => di.sl<LoginBloc>(),
        child: LoginForm(),
      ),
    );
  }
}
