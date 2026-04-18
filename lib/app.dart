import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/common/widgets/app_notification_overlay_host.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/utils/notifications/notification_service.dart';
import 'injection_container.dart';
import 'l10n/app_localizations.dart';
import 'routes/app_router.dart';

class CelestApp extends StatelessWidget {
  const CelestApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = sl<ThemeController>();
    final notificationService = sl<NotificationService>();

    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return MaterialApp.router(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: AppRouter.router,
          builder: (context, child) {
            return AppNotificationOverlayHost(
              notificationService: notificationService,
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
