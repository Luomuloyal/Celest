import 'app_keys.dart';

abstract final class NotificationConstants {
  static const String defaultChannelId = 'celest.general';
  static const String defaultChannelName = 'Celest General';
  static const String defaultChannelDescription = 'Celest app notifications';

  static const String androidSmallIcon = 'app_notification_icon';
  static const String linuxDefaultActionName = 'Open notification';

  static const String windowsAppName = AppKeys.appName;
  static const String windowsAppUserModelId = 'com.devluo.celest';
  static const String windowsGuid = 'f632b398-1bf1-4c00-a11c-8c26162d8196';

  static const String webDefaultIconPath = '/icons/Icon-192.png';
}
