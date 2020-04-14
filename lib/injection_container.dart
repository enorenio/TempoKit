import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'util/api_client.dart';
import 'util/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! ApiClient
  sl.registerLazySingleton(() => ApiClient(client: sl()));
  //! Bloc
  initBloc();
  //! Core
  initCore();
  //! External
  await initExternal();
}

void initBloc() {
  //...
}

void initCore() {
  sl.registerLazySingleton(() => NetworkInfo(sl()));
}

Future<void> initExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}