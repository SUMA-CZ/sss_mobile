import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry/sentry.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';
import 'package:sss_mobile/core/ui/widgets/loading_indicator.dart';
import 'package:sss_mobile/env_config.dart';

import 'core/authorization/auth_bloc.dart';
import 'core/authorization/auth_events.dart';
import 'core/authorization/auth_state.dart';
import 'core/network/authorization_interceptor.dart';
import 'core/ui/screens/splash_screen.dart';
import 'features/login/domain/repositories/user_repository.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/vehicles/presentation/vehicles_screen/bloc/vehicles_bloc.dart';
import 'features/vehicles/presentation/vehicles_screen/vehicles_page.dart';
import 'injection_container.dart' as di;

final sentry =
    SentryClient(dsn: 'https://df77b1de3d3440958fb5133f3ea23914@o224610.ingest.sentry.io/5516756');

class SSSMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xff2d3663),
          accentColor: Color(0xffff8f00),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xffff8f00), // Background color (orange in my case).
            colorScheme:
                Theme.of(context).colorScheme.copyWith(secondary: Colors.white), // Text color
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              splashColor: Colors.white.withOpacity(0.25), backgroundColor: Color(0xffff8f00))),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) => di.sl<AuthenticationBloc>()..add(AppStarted()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return BlocProvider(
                create: (_) => di.sl<VehiclesBloc>()..add(VehiclesEventRead()),
                child: VehiclesPage(),
              );
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: di.sl<UserRepository>());
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  // di.sl<Dio>().interceptors.add(PrettyDioLogger(
  //     requestHeader: true,
  //     requestBody: true,
  //     responseBody: true,
  //     responseHeader: true,
  //     error: true,
  //     compact: true,
  //     maxWidth: 90));

  // Bloc.observer = LogBlocObserver();
  di.sl<Dio>().interceptors.add(AuthorizationInterceptor(repo: di.sl<UserRepository>()));

  runZonedGuarded(
    () => runApp(SSSMobile()),
    (error, stackTrace) async {
      if (EnvConfig.API_URL.contains('sss.sumanet')) {
        await sentry.captureException(
          exception: error,
          stackTrace: stackTrace,
        );
      }
    },
  );

  await sentry.capture(
      event: Event(
          level: SeverityLevel.info, message: 'App Started', environment: EnvConfig.SENTRY_ENV));
}
