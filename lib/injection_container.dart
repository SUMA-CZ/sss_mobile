import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss_mobile/features/login/domain/usecases/authenticate.dart';
import 'package:sss_mobile/features/login/presentation/bloc/login.dart';

import 'core/authorization/auth_bloc.dart';
import 'features/login/data/datasources/account_datasource.dart';
import 'features/login/data/repositories/user_repository_impl.dart';
import 'features/login/domain/repositories/user_repository.dart';
import 'features/vehicles/data/datasources/vehicles_datasource.dart';
import 'features/vehicles/data/repositories/vehicle_repository_impl.dart';
import 'features/vehicles/domain/repositories/vehicle_repository.dart';
import 'features/vehicles/domain/usecases/get_vehicles.dart';
import 'features/vehicles/presentation/vehicle_list_screen/bloc/get_vehicles_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Vehicles
  /// Bloc
  /// Always new instance on a call -- factory
  sl.registerFactory(() => GetVehiclesBloc(getVehicles: sl()));
  sl.registerFactory(() => LoginBloc(authenticate: sl(), authenticationBloc: sl()));

  /// Auth
  sl.registerLazySingleton(() => AuthenticationBloc(userRepository: sl()));

  /// Features
  /// Usecases -- can be singleton, no streams can stay in memory
  sl.registerLazySingleton(() => GetVehicles(sl()));
  sl.registerLazySingleton(() => Authenticate(sl()));

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
