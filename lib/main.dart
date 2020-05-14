import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sss_mobile/apis/vehicle_api.dart';
import 'package:sss_mobile/login/login_page.dart';
import 'package:sss_mobile/repositories/user_repo.dart';
import 'package:sss_mobile/repositories/vehicle_repo.dart';
import 'package:sss_mobile/screens/loading_indicator.dart';
import 'package:sss_mobile/screens/splash_screen.dart';
import 'package:sss_mobile/vehicles/vehicle_bloc.dart';
import 'package:sss_mobile/vehicles/vehicles.dart';

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
  final vehicleRepository = VehicleRepository(vehicleAPI: VehicleAPI());


  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: App(userRepository: userRepository, vehicleRepository: vehicleRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final VehicleRepository vehicleRepository;

  App({Key key, @required this.userRepository, @required this.vehicleRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return BlocProvider(create: (context) => VehicleBloc(vehicleRepository: vehicleRepository), child: Vehicles());
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