import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tempokit/util/bloc/account/account_bloc.dart';
import 'package:tempokit/util/bloc/inbox/inbox_bloc.dart';
import 'package:tempokit/util/bloc/my_tasks/my_tasks_bloc.dart';
import 'package:tempokit/util/cache_controller.dart';
import 'package:tempokit/util/bloc/home/home_bloc.dart';

import 'util/api_client.dart';
import 'util/bloc/auth/auth_bloc.dart';
import 'util/network/network_info.dart';
import 'util/repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Cache
  sl.registerLazySingleton(() => CacheController(sharedPreferences: sl()));
  //! ApiClient
  sl.registerLazySingleton(() => ApiClient(client: sl()));
  //! Bloc
  _initBloc();
  //! Repository
  sl.registerLazySingleton(() =>
      Repository(apiClient: sl(), networkInfo: sl(), cacheController: sl()));
  //! Core
  _initCore();
  //! External
  await _initExternal();
}

void _initBloc() {
  sl.registerFactory(() => AuthBloc(repository: sl()));
  sl.registerFactory(() => HomeBloc(repository: sl()));
  sl.registerFactory(() => MyTasksBloc(repository: sl()));
  sl.registerFactory(() => InboxBloc(repository: sl()));
  sl.registerFactory(() => AccountBloc(repository: sl()));
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
