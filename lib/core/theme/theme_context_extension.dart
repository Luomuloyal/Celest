import 'package:flutter/material.dart';

import 'app_theme_extension.dart';

extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => theme.colorScheme;

  TextTheme get textStyles => theme.textTheme;

  AppThemeExtension get appTheme =>
      theme.extension<AppThemeExtension>() ??
      const AppThemeExtension(
        pageGradientStart: Colors.white,
        pageGradientEnd: Colors.white,
        sectionBackground: Colors.white,
        sectionBorder: Colors.transparent,
        sectionShadow: Colors.transparent,
        heroGradientStart: Colors.blue,
        heroGradientEnd: Colors.lightBlue,
        pillBackground: Colors.blue,
        pillForeground: Colors.white,
        pillMutedBackground: Color(0xFFF2F4F6),
        pillMutedForeground: Color(0xFF3F484E),
        inputBackground: Color(0xFFF6F8FA),
        inputBorder: Color(0x22000000),
        tileBackground: Color(0xFFF4F6F8),
        tilePressedBackground: Color(0xFFE7EEF4),
        notificationSuccess: Colors.green,
        notificationInfo: Colors.blue,
      );
}
