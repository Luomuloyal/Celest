import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/notifications/notification_service.dart';

Never _missingOverride(String providerName) {
  throw UnimplementedError(
    '$providerName must be overridden during app bootstrap.',
  );
}

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => _missingOverride('sharedPreferencesProvider'),
);

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => _missingOverride('notificationServiceProvider'),
);

List<Override> buildAppServiceOverrides({
  required SharedPreferences sharedPreferences,
  required NotificationService notificationService,
}) {
  return [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    notificationServiceProvider.overrideWithValue(notificationService),
  ];
}
