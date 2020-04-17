import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'util/api_client.dart';
import 'util/bloc/auth_bloc.dart';
import 'util/bloc/utility_bloc.dart';
import 'util/network/network_info.dart';
import 'util/repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! ApiClient
  sl.registerLazySingleton(() => ApiClient(client: sl()));
  //! Bloc
  _initBloc();
  //! Repository
  sl.registerLazySingleton<Repository>(() => Repository(
        apiClient: sl(),
        networkInfo: sl(),
      ));
  //! Core
  _initCore();
  //! External
  await _initExternal();
}

void _initBloc() {
  sl.registerFactory(() => AuthBloc());
  sl.registerFactory(() => UtilityBloc());
}

void _initCore() {
  sl.registerLazySingleton(() => NetworkInfo(sl()));
}

Future<void> _initExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
