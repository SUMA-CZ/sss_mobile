//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:sss_mobile/screens/login_form.dart';
//
//import 'networking/custom_proxy.dart';
//import 'string.dart';
//
//void main() async {
//  if (!kReleaseMode) {
//    // For Android devices you can also allowBadCertificates: true below, but you should ONLY do this when !kReleaseMode
//    final proxy = CustomProxy(ipAddress: "localhost", port: 8888);
//    proxy.enable();
//  }
//
//  // Run app
//  runApp(SSSApp());
//}
//
//class SSSApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(title: Strings.appTitle, home: new LoginForm());
//  }
//}


import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sss_mobile/login/login_page.dart';
import 'package:sss_mobile/repository/user_repo.dart';
import 'package:sss_mobile/screens/loading_indicator.dart';
import 'package:sss_mobile/screens/splash_screen.dart';
import 'package:sss_mobile/screens/vehicle_list_screen.dart';

import 'auth/auth_bloc.dart';
import 'auth/auth_events.dart';
import 'auth/auth_state.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return VehicleListScreen();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return SplashScreen();
        },
      ),
    );
  }
}