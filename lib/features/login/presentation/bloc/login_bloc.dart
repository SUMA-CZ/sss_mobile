import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sss_mobile/core/authorization/auth_bloc.dart';
import 'package:sss_mobile/core/authorization/auth_events.dart';
import 'package:sss_mobile/features/login/data/models/e_user_credentitials_model.dart';
import 'package:sss_mobile/features/login/domain/repositories/user_repository.dart';

import 'login_events.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final either = await userRepository.authenticate(
            EUserCredentialsModel(username: event.username, password: event.password));

        yield either.fold((l) {
          return LoginFailure(error: 'null');
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
