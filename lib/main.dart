import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sss_mobile/A_old_bloc/screens/splash_screen.dart';

import 'core/authorization/auth_bloc.dart';
import 'core/authorization/auth_events.dart';
import 'core/authorization/auth_state.dart';
import 'core/bloc/log_bloc_observer.dart';
import 'features/login/domain/repositories/user_repository.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/vehicles/presentation/bloc/get_vehicles_bloc.dart';
import 'features/vehicles/presentation/pages/vehicles_page.dart';
import 'injection_container.dart' as di;

class SCMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) => di.sl<AuthenticationBloc>()..add(AppStarted()),
        child: MaterialApp(
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                return BlocProvider(
                  create: (_) => di.sl<GetVehiclesBloc>()..add(GetVehiclesEventGetVehicles()),
                  child: VehiclesPage(),
                );
              }
              if (state is AuthenticationUnauthenticated) {
                return LoginPage(userRepository: di.sl<UserRepository>());
              }
              if (state is AuthenticationLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SplashScreen();
            },
          ),
        ));
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = LogBlocObserver();
  di.sl<Dio>().interceptors.add(di.SCMInterceptor(repo: di.sl<UserRepository>()));
  runApp(SCMApp());
}
