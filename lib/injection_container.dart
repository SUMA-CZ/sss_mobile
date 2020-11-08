import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/authorization/auth_bloc.dart';
import 'features/login/data/datasources/account_datasource.dart';
import 'features/login/data/repositories/user_repository_impl.dart';
import 'features/login/domain/repositories/user_repository.dart';
import 'features/vehicles/data/datasources/vehicles_datasource.dart';
import 'features/vehicles/data/repositories/vehicle_repository_impl.dart';
import 'features/vehicles/domain/repositories/vehicle_repository.dart';
import 'features/vehicles/domain/usecases/get_vehicles.dart';
import 'features/vehicles/presentation/bloc/get_vehicles_bloc.dart';

final sl = GetIt.instance;

class SCMInterceptor extends Interceptor {
  UserRepository repo;

  SCMInterceptor({@required this.repo});

  @override
  Future onRequest(RequestOptions options) async {
    repo.accessToken().fold((l) {
      print('No Token');
    }, (r) {
      options.headers["Authorization"] = 'Bearer $r';
    });

    return options;
  }
}

Future<void> init() async {
  /// Features - Vehicles
  /// Bloc
  /// Always new instance on a call -- factory
  sl.registerFactory(() => GetVehiclesBloc(getVehicles: sl()));

  /// Auth
  sl.registerFactory(() => AuthenticationBloc(userRepository: sl()));

  /// Features
  /// Usecases -- can be singleton, no streams can stay in memory
  sl.registerLazySingleton(() => GetVehicles(sl()));

  /// Repository
  sl.registerLazySingleton<VehicleRepository>(() => VehicleRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(prefs: sl(), dataSource: sl()));

  /// Data sources
  sl.registerLazySingleton<VehiclesRemoteDataSource>(
      () => VehiclesRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<AccountDataSource>(() => AccountDataSourceImpl(client: sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}
