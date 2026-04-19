import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/common/providers/app_service_providers.dart';
import 'core/utils/notifications/notification_service.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final notificationService = NotificationService();
  try {
    await notificationService.initialize();
  } catch (_) {
    // Keep app startup resilient even if native notification setup fails.
  }
  runApp(
    ProviderScope(
      overrides: buildAppServiceOverrides(
        sharedPreferences: sharedPreferences,
        notificationService: notificationService,
      ),
      child: const CelestApp(),
    ),
  );
}
