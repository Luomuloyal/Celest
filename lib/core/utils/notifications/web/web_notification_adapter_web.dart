import 'dart:js_interop';

import 'package:web/web.dart' as web;

import '../../../constants/notification_constants.dart';
import '../models/app_notification.dart';
import '../models/notification_permission_state.dart';

class WebNotificationAdapter {
  const WebNotificationAdapter();

  bool get isSupported => true;

  Future<NotificationPermissionState> getPermissionState() async {
    return _mapPermission(web.Notification.permission);
  }

  Future<NotificationPermissionState> requestPermission() async {
    final result = await web.Notification.requestPermission().toDart;
    return _mapPermission(result.toDart);
  }

  Future<bool> show(AppNotification notification) async {
    final permission = await getPermissionState();
    final effectivePermission = permission == NotificationPermissionState.granted
        ? permission
        : await requestPermission();

    if (effectivePermission != NotificationPermissionState.granted) {
      return false;
    }

    web.Notification(
      notification.title,
      web.NotificationOptions(
        body: notification.body,
        tag: notification.id.toString(),
        icon: NotificationConstants.webDefaultIconPath,
      ),
    );

    return true;
  }

  NotificationPermissionState _mapPermission(String permission) {
    switch (permission) {
      case 'granted':
        return NotificationPermissionState.granted;
      case 'denied':
        return NotificationPermissionState.denied;
      default:
        return NotificationPermissionState.notDetermined;
    }
  }
}
