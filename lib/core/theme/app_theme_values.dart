import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_theme_extension.dart';

abstract final class AppThemeValues {
  static const AppThemeExtension light = AppThemeExtension(
    pageGradientStart: Color(0xFFF8FAFD),
    pageGradientEnd: Color(0xFFEFF5FA),
    sectionBackground: AppColors.surfaceContainerLowest,
    sectionBorder: Color(0x1ABEC8CE),
    sectionShadow: Color(0x14006686),
    heroGradientStart: Color(0xFF1B7BA5),
    heroGradientEnd: Color(0xFF6BC7F2),
    pillBackground: Color(0xFFD8EFF9),
    pillForeground: AppColors.primary,
    pillMutedBackground: Color(0xFFF0F3F6),
    pillMutedForeground: AppColors.onSurfaceVariant,
    inputBackground: Color(0xFFF6F8FA),
    inputBorder: Color(0x22BEC8CE),
    tileBackground: Color(0xFFF4F6F8),
    tilePressedBackground: Color(0xFFE7EEF4),
    notificationSuccess: Color(0xFF2E9B64),
    notificationInfo: AppColors.primary,
  );

  static const AppThemeExtension dark = AppThemeExtension(
    pageGradientStart: Color(0xFF0C1116),
    pageGradientEnd: Color(0xFF121A22),
    sectionBackground: Color(0xFF151D26),
    sectionBorder: Color(0x22374757),
    sectionShadow: Color(0x66000000),
    heroGradientStart: Color(0xFF115E80),
    heroGradientEnd: Color(0xFF288EC0),
    pillBackground: Color(0xFF173647),
    pillForeground: Color(0xFFB7E7FF),
    pillMutedBackground: Color(0xFF212D39),
    pillMutedForeground: Color(0xFFC1CCD6),
    inputBackground: Color(0xFF101820),
    inputBorder: Color(0x33485B6B),
    tileBackground: Color(0xFF19232D),
    tilePressedBackground: Color(0xFF23303D),
    notificationSuccess: Color(0xFF43C07F),
    notificationInfo: Color(0xFF6BC7F2),
  );
}
