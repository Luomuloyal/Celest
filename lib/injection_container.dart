import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/utils/network/api_client.dart';
import 'core/utils/network/api_error_handler.dart';
import 'core/utils/network/interceptors/api_logging_interceptor.dart';
import 'core/utils/network/interceptors/auth_interceptor.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  if (!sl.isRegistered<ApiErrorHandler>()) {
    sl.registerLazySingleton<ApiErrorHandler>(() => const ApiErrorHandler());
  }

  if (!sl.isRegistered<AuthInterceptor>()) {
    sl.registerLazySingleton<AuthInterceptor>(AuthInterceptor.new);
  }

  if (!sl.isRegistered<ApiLoggingInterceptor>()) {
    sl.registerLazySingleton<ApiLoggingInterceptor>(
      () => const ApiLoggingInterceptor(),
    );
  }

  if (!sl.isRegistered<Dio>()) {
    sl.registerLazySingleton<Dio>(Dio.new);
  }

  if (!sl.isRegistered<ApiClient>()) {
    sl.registerLazySingleton<ApiClient>(
      () => ApiClient(
        dio: sl<Dio>(),
        errorHandler: sl<ApiErrorHandler>(),
        authInterceptor: sl<AuthInterceptor>(),
        loggingInterceptor: sl<ApiLoggingInterceptor>(),
      ),
    );
  }
}
