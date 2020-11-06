import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss_mobile/clean_architecture/core/network/interceptor.dart';
import 'package:sss_mobile/clean_architecture/features/login/data/repositories/user_repository_impl.dart';
import 'package:sss_mobile/clean_architecture/features/login/domain/repositories/user_repository.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/datasources/vehicles_datasource.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/data/repositories/vehicle_repository_impl.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/domain/usecases/get_vehicles.dart';
import 'package:sss_mobile/clean_architecture/features/vehicles/presentation/bloc/get_vehicles_bloc.dart';

final g = GetIt.instance;

Future<void> init() async {
  /// Features - Vehicles
  /// Bloc
  /// Always new instance on a call -- factory
  g.registerFactory(() => GetVehiclesBloc(getVehicles: g()));

  /// Features
  /// Usecases -- can be singleton, no streams can stay in memory
  g.registerLazySingleton(() => GetVehicles(g()));

  /// Repository
  g.registerLazySingleton<VehicleRepository>(() => VehicleRepositoryImpl(remoteDataSource: g()));
  g.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(prefs: g()));

  /// Data sources
  g.registerLazySingleton<VehiclesRemoteDataSource>(
      () => VehiclesRemoteDataSourceImpl(client: g()));

  /// External

  g.registerLazySingleton<InterceptorContract>(() => AuthorizationInterceptor());
  g.registerLazySingleton<Client>(() => HttpClientWithInterceptor.build(interceptors: [g()]));
  final sharedPreferences = await SharedPreferences.getInstance();
  g.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
