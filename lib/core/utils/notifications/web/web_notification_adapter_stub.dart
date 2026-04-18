import '../models/app_notification.dart';
import '../models/notification_permission_state.dart';

class WebNotificationAdapter {
  const WebNotificationAdapter();

  bool get isSupported => false;

  Future<NotificationPermissionState> getPermissionState() async {
    return NotificationPermissionState.unsupported;
  }

  Future<NotificationPermissionState> requestPermission() async {
    return NotificationPermissionState.unsupported;
  }

  Future<bool> show(AppNotification notification) async {
    return false;
  }
}
