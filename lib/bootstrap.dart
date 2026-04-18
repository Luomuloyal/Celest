import 'package:flutter/widgets.dart';

import 'app.dart';
import 'core/theme/theme_controller.dart';
import 'injection_container.dart' as di;
import 'core/utils/notifications/notification_service.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureDependencies();
  await di.sl<ThemeController>().load();
  await di.sl<NotificationService>().initialize();
  runApp(const CelestApp());
}
