import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'injection_container.dart' as di;
import 'core/utils/notifications/notification_service.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureDependencies();
  try {
    await di.sl<NotificationService>().initialize();
  } catch (_) {
    // Keep app startup resilient even if native notification setup fails.
  }
  runApp(const ProviderScope(child: CelestApp()));
}
