import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../constants/notification_constants.dart';
import 'models/app_notification.dart';
import 'models/notification_delivery_type.dart';
import 'models/notification_permission_state.dart';
import 'models/notification_result.dart';
import 'models/notification_target.dart';
import 'web/web_notification_adapter.dart';

class NotificationService {
  NotificationService({
    FlutterLocalNotificationsPlugin? plugin,
    WebNotificationAdapter? webAdapter,
  })  : _plugin = plugin ?? FlutterLocalNotificationsPlugin(),
        _webAdapter = webAdapter ?? const WebNotificationAdapter();

  final FlutterLocalNotificationsPlugin _plugin;
  final WebNotificationAdapter _webAdapter;
  final StreamController<AppNotification> _inAppNotificationsController =
      StreamController<AppNotification>.broadcast();

  bool _initialized = false;
  int _localIdSeed = 100000;

  Stream<AppNotification> get inAppNotifications =>
      _inAppNotificationsController.stream;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    if (kIsWeb) {
      _initialized = true;
      return;
    }

    const android = AndroidInitializationSettings(
      NotificationConstants.androidSmallIcon,
    );
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const linux = LinuxInitializationSettings(
      defaultActionName: NotificationConstants.linuxDefaultActionName,
    );
    const windows = WindowsInitializationSettings(
      appName: NotificationConstants.windowsAppName,
      appUserModelId: NotificationConstants.windowsAppUserModelId,
      guid: NotificationConstants.windowsGuid,
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: android,
        iOS: darwin,
        macOS: darwin,
        linux: linux,
        windows: windows,
      ),
    );

    await _createAndroidDefaultChannel();
    _initialized = true;
  }

  Future<NotificationPermissionState> requestPermission() async {
    await initialize();

    if (kIsWeb) {
      return _webAdapter.requestPermission();
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final result = await _plugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
        return _mapBooleanPermission(result);
      case TargetPlatform.iOS:
        final result = await _plugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
        return _mapBooleanPermission(result);
      case TargetPlatform.macOS:
        final result = await _plugin
            .resolvePlatformSpecificImplementation<
                MacOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
        return _mapBooleanPermission(result);
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return NotificationPermissionState.granted;
      case TargetPlatform.fuchsia:
        return NotificationPermissionState.unsupported;
    }
  }

  Future<NotificationResult> show(
    AppNotification notification, {
    NotificationTarget target = NotificationTarget.preferSystem,
  }) async {
    await initialize();

    if (target == NotificationTarget.inAppOnly) {
      return _deliverInApp(notification);
    }

    var permissionState = await _resolvePermissionState();
    if (permissionState == NotificationPermissionState.notDetermined) {
      permissionState = await requestPermission();
    }

    final canUseSystem =
        permissionState == NotificationPermissionState.granted ||
            permissionState == NotificationPermissionState.unsupported;

    if (target != NotificationTarget.inAppOnly && canUseSystem) {
      final delivered = await _showSystemNotification(notification);
      if (delivered) {
        return NotificationResult(
          delivered: true,
          deliveryType: NotificationDeliveryType.system,
          permissionState: permissionState,
        );
      }
    }

    if (target == NotificationTarget.systemOnly) {
      return NotificationResult(
        delivered: false,
        deliveryType: NotificationDeliveryType.system,
        permissionState: permissionState,
      );
    }

    return _deliverInApp(notification, permissionState: permissionState);
  }

  Future<void> cancel(int id) {
    return _plugin.cancel(id);
  }

  Future<void> cancelAll() {
    return _plugin.cancelAll();
  }

  Future<NotificationResult> showInfo(
    String title,
    String body, {
    NotificationTarget target = NotificationTarget.preferSystem,
    String? payload,
  }) {
    return show(
      AppNotification(
        id: _nextId(),
        title: title,
        body: body,
        payload: payload,
      ),
      target: target,
    );
  }

  Future<void> dispose() async {
    await _inAppNotificationsController.close();
  }

  Future<void> _createAndroidDefaultChannel() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        NotificationConstants.defaultChannelId,
        NotificationConstants.defaultChannelName,
        description: NotificationConstants.defaultChannelDescription,
        importance: Importance.high,
      ),
    );
  }

  Future<NotificationPermissionState> _resolvePermissionState() async {
    if (kIsWeb) {
      return _webAdapter.getPermissionState();
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final enabled = await _plugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled();
        return _mapBooleanPermission(enabled);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return NotificationPermissionState.notDetermined;
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return NotificationPermissionState.granted;
      case TargetPlatform.fuchsia:
        return NotificationPermissionState.unsupported;
    }
  }

  Future<bool> _showSystemNotification(AppNotification notification) async {
    try {
      if (kIsWeb) {
        return _webAdapter.show(notification);
      }

      await _plugin.show(
        notification.id,
        notification.title,
        notification.body,
        _buildNotificationDetails(notification),
        payload: notification.payload,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  NotificationDetails _buildNotificationDetails(AppNotification notification) {
    final channelId =
        notification.channelId ?? NotificationConstants.defaultChannelId;
    final channelName =
        notification.channelName ?? NotificationConstants.defaultChannelName;
    final channelDescription = notification.channelDescription ??
        NotificationConstants.defaultChannelDescription;

    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
      macOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
      linux: const LinuxNotificationDetails(),
      windows: const WindowsNotificationDetails(),
    );
  }

  NotificationResult _deliverInApp(
    AppNotification notification, {
    NotificationPermissionState permissionState =
        NotificationPermissionState.unsupported,
  }) {
    _inAppNotificationsController.add(notification);
    return NotificationResult(
      delivered: true,
      deliveryType: NotificationDeliveryType.inApp,
      permissionState: permissionState,
    );
  }

  NotificationPermissionState _mapBooleanPermission(bool? granted) {
    if (granted == null) {
      return NotificationPermissionState.notDetermined;
    }

    return granted
        ? NotificationPermissionState.granted
        : NotificationPermissionState.denied;
  }

  int _nextId() {
    _localIdSeed += 1;
    return _localIdSeed;
  }
}
