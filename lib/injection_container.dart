import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sss_mobile/features/login/domain/usecases/authenticate.dart';
import 'package:sss_mobile/features/login/presentation/bloc/login.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/currency_datasource.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/fuel_types_datasource.dart';
import 'package:sss_mobile/features/vehicles/data/datasources/vat_rates_datasource.dart';
import 'package:sss_mobile/features/vehicles/data/repositories/currency_repository_impl.dart';
import 'package:sss_mobile/features/vehicles/data/repositories/fuel_type_repository_impl.dart';
import 'package:sss_mobile/features/vehicles/data/repositories/vat_rate_repository_imp.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/currency_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/repositories/vat_rate_repository.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_maintenace.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/create_trip.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/delete_trip.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_currencies.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_fuel_types.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_maintenances_for_vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_refuelings_for_vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_trips_for_vehicle.dart';
import 'package:sss_mobile/features/vehicles/domain/usecases/read_vat_rates.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/maintenance/cubit/maintenance_form_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/refueling/cubit/refueling_form_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/forms/trip/cubit/trip_form_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/maintenances/maintenances_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/refuelings/refuelings_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/trips/trips_cubit.dart';
import 'package:sss_mobile/features/vehicles/presentation/vehicle_detail_screen/cubit/vehicle_detail_cubit.dart';

import 'core/authorization/auth_bloc.dart';
import 'features/login/data/datasources/account_datasource.dart';
import 'features/login/data/repositories/user_repository_impl.dart';
import 'features/login/domain/repositories/user_repository.dart';
import 'features/vehicles/data/datasources/vehicles_datasource.dart';
import 'features/vehicles/data/repositories/vehicle_repository_impl.dart';
import 'features/vehicles/domain/repositories/fuel_type_repository.dart';
import 'features/vehicles/domain/repositories/vehicle_repository.dart';
import 'features/vehicles/domain/usecases/read_vehicle.dart';
import 'features/vehicles/domain/usecases/read_vehicles.dart';
import 'features/vehicles/presentation/vehicles_screen/bloc/vehicles_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Vehicles
  /// Bloc
  /// Always new instance on a call -- factory
  sl.registerFactory(() => VehiclesBloc(getVehicles: sl()));
  sl.registerFactory(() => LoginBloc(authenticate: sl(), authenticationBloc: sl()));

  sl.registerFactoryParam((param1, param2) => VehicleDetailCubit(vehicle: param1, usecase: sl()));

  sl.registerFactoryParam(
      (param1, param2) => TripFormCubit(usecase: sl(), vehicle: param1, tripListCubit: param2));
  sl.registerFactoryParam((param1, param2) => RefuelingFormCubit(
      readFuelTypes: sl(),
      readVatRates: sl(),
      createRefuelingUseCase: sl(),
      readCurrency: sl(),
      vehicle: param1));
  sl.registerFactoryParam((param1, param2) => MaintenanceFormCubit(usecase: sl(), vehicle: param1));
  sl.registerFactoryParam(
      (param1, param2) => TripsCubit(getTripsForVehicle: sl(), deleteTrip: sl(), vehicle: param1));
  sl.registerFactoryParam((param1, param2) =>
      RefuelingsCubit(getRefuelingsForVehicle: sl(), deleteRefueling: sl(), vehicle: param1));
  sl.registerFactoryParam((param1, param2) =>
      MaintenancesCubit(getMaintenancesForTrip: sl(), deleteMaintenance: sl(), vehicle: param1));

  /// Auth
  sl.registerLazySingleton(() => AuthenticationBloc(userRepository: sl()));

  /// Features
  /// Usecases -- can be singleton, no streams can stay in memory
  sl.registerLazySingleton(() => Authenticate(sl()));
  sl.registerLazySingleton(() => ReadVehicles(sl()));
  sl.registerLazySingleton(() => ReadVehicle(sl()));
  sl.registerLazySingleton(() => DeleteTrip(sl()));
  sl.registerLazySingleton(() => DeleteRefueling(sl()));
  sl.registerLazySingleton(() => DeleteMaintenance(sl()));
  sl.registerLazySingleton(() => ReadTripsForVehicle(sl()));
  sl.registerLazySingleton(() => ReadRefuelingsForVehicle(sl()));
  sl.registerLazySingleton(() => ReadMaintenancesForVehicle(sl()));
  sl.registerLazySingleton(() => CreateTrip(repository: sl()));
  sl.registerLazySingleton(() => CreateMaintenance(repository: sl()));
  sl.registerLazySingleton(() => CreateRefueling(repository: sl()));
  sl.registerLazySingleton(() => ReadVatRates(sl()));
  sl.registerLazySingleton(() => ReadFuelTypes(sl()));
  sl.registerLazySingleton(() => ReadCurrency(sl()));

  /// Repository
  sl.registerLazySingleton<VehicleRepository>(() => VehicleRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(prefs: sl(), dataSource: sl()));
  sl.registerLazySingleton<FuelTypeRepository>(
      () => FuelTypeRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<VatRateRepository>(() => VatRateRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<CurrencyRepository>(() => CurrencyRepositoryImpl(dataSource: sl()));

  /// Data sources
  sl.registerLazySingleton<VehiclesRemoteDataSource>(
      () => VehiclesRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<VatRatesDataSource>(() => VatRatesDataSourceImpl(client: sl()));
  sl.registerLazySingleton<FuelTypesDataSource>(() => FuelTypesDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AccountDataSource>(() => AccountDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CurrencyDataSource>(() => CurrencyDataSourceImpl(client: sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}
