import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sss_mobile/apis/vehicle_api.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/presentation/bloc/get_vehicles_bloc.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/presentation/pages/vehicles_page.dart';
import 'package:sss_mobile/repositories/user_repo.dart';
import 'package:sss_mobile/repositories/vehicle_repo.dart';
import 'package:sss_mobile/screens/loading_indicator.dart';
import 'package:sss_mobile/screens/splash_screen.dart';

import 'auth/auth_bloc.dart';
import 'auth/auth_events.dart';
import 'auth/auth_state.dart';
import 'blocs/login/login_page.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();

  final userRepository = UserRepository();
  final vehicleRepository = VehicleRepository(vehicleAPI: VehicleAPI());

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)..add(AppStarted());
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
            return BlocProvider(
              create: (BuildContext context) => di.g<GetVehiclesBloc>(),
              child: VehiclesPage(),
            );
            // return BlocProvider(create: () => ,) VehiclesPage();
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
