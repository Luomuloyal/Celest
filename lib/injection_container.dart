import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/theme_controller.dart';
import 'core/utils/network/api_client.dart';
import 'core/utils/network/api_error_handler.dart';
import 'core/utils/network/interceptors/api_logging_interceptor.dart';
import 'core/utils/network/interceptors/auth_interceptor.dart';
import 'core/utils/notifications/notification_service.dart';
import 'core/utils/notifications/web/web_notification_adapter.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  if (!sl.isRegistered<SharedPreferences>()) {
    final preferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => preferences);
  }

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

  if (!sl.isRegistered<FlutterLocalNotificationsPlugin>()) {
    sl.registerLazySingleton<FlutterLocalNotificationsPlugin>(
      FlutterLocalNotificationsPlugin.new,
    );
  }

  if (!sl.isRegistered<WebNotificationAdapter>()) {
    sl.registerLazySingleton<WebNotificationAdapter>(
      () => const WebNotificationAdapter(),
    );
  }

  if (!sl.isRegistered<ThemeController>()) {
    sl.registerLazySingleton<ThemeController>(
      () => ThemeController(sl<SharedPreferences>()),
    );
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

  if (!sl.isRegistered<NotificationService>()) {
    sl.registerLazySingleton<NotificationService>(
      () => NotificationService(
        plugin: sl<FlutterLocalNotificationsPlugin>(),
        webAdapter: sl<WebNotificationAdapter>(),
      ),
    );
  }
}
