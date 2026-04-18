import 'notification_delivery_type.dart';
import 'notification_permission_state.dart';

class NotificationResult {
  const NotificationResult({
    required this.delivered,
    required this.deliveryType,
    required this.permissionState,
  });

  final bool delivered;
  final NotificationDeliveryType deliveryType;
  final NotificationPermissionState permissionState;
}
