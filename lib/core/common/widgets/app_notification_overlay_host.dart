import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/theme_context_extension.dart';
import '../../utils/notifications/models/app_notification.dart';
import '../../utils/notifications/notification_service.dart';

class AppNotificationOverlayHost extends StatefulWidget {
  const AppNotificationOverlayHost({
    super.key,
    required this.notificationService,
    required this.child,
  });

  final NotificationService notificationService;
  final Widget child;

  @override
  State<AppNotificationOverlayHost> createState() =>
      _AppNotificationOverlayHostState();
}

class _AppNotificationOverlayHostState extends State<AppNotificationOverlayHost> {
  StreamSubscription<AppNotification>? _subscription;
  AppNotification? _notification;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _subscription = widget.notificationService.inAppNotifications.listen(
      _showNotification,
    );
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _subscription?.cancel();
    super.dispose();
  }

  void _showNotification(AppNotification notification) {
    _dismissTimer?.cancel();
    setState(() {
      _notification = notification;
    });

    _dismissTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _notification = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top + AppSpacing.md;

    return Stack(
      children: [
        widget.child,
        Positioned(
          top: topInset,
          left: AppSpacing.md,
          right: AppSpacing.md,
          child: IgnorePointer(
            ignoring: _notification == null,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              offset:
                  _notification == null ? const Offset(0, -0.25) : Offset.zero,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: _notification == null ? 0 : 1,
                child: _notification == null
                    ? const SizedBox.shrink()
                    : _NotificationCard(
                        notification: _notification!,
                        onClose: () {
                          _dismissTimer?.cancel();
                          setState(() {
                            _notification = null;
                          });
                        },
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.notification,
    required this.onClose,
  });

  final AppNotification notification;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: appTheme.sectionBorder),
          boxShadow: [
            BoxShadow(
              color: appTheme.sectionShadow,
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: appTheme.notificationInfo,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.smPlus),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(notification.title, style: AppTextStyles.label),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      notification.body,
                      style: AppTextStyles.caption.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton(
                onPressed: onClose,
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.close,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
