import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loginandregister_flutter/providers/auth_provider.dart';
import 'package:loginandregister_flutter/remote/dio/dio_client.dart';
import 'package:loginandregister_flutter/remote/dio/logging_interceptor.dart';
import 'package:loginandregister_flutter/repo/auth_repo.dart';
import 'package:loginandregister_flutter/repo/splash_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_constant.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(
      () => SplashRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  // sl.registerLazySingleton(
  //     () => HomeRepo(dioClient: sl(), sharedPreferences: sl()));

  // Provider

  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  // sl.registerFactory(() => HomeProvider(homeRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
