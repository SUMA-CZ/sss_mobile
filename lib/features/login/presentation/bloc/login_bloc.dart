import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/authorization/auth_bloc.dart';
import 'package:sss_mobile/core/authorization/auth_events.dart';
import 'package:sss_mobile/features/login/data/models/user_credentitials_model.dart';
import 'package:sss_mobile/features/login/domain/usecases/authenticate.dart';

import 'login_events.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Authenticate authenticate;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticate,
    @required this.authenticationBloc,
  })  : assert(authenticate != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final either = await authenticate(
            UserCredentialsModel(username: event.username, password: event.password));

        yield either.fold((l) {
          authenticationBloc.add(LoggedOut());
          return LoginFailure(error: 'Authentication Failed');
        }, (r) {
          authenticationBloc.add(LoggedIn(token: r.accessToken));
          return LoginInitial();
        });
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
