import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injection_container.dart';
import '../../utils/notifications/notification_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => sl<SharedPreferences>(),
);

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => sl<NotificationService>(),
);
