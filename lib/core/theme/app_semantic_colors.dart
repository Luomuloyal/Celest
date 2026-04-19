import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppSemanticColors {
  static const Color textPrimary = AppColors.onSurface;
  static const Color textSecondary = AppColors.onSurfaceVariant;
  static const Color textDisabled = Color(0xFF8C959D);

  static const Color borderDefault = Color(0x1ABEC8CE);
  static const Color borderStrong = Color(0x33A8B6C3);
  static const Color borderError = Color(0x33BA1A1A);

  static const Color fillDefault = AppColors.surfaceContainerLowest;
  static const Color fillMuted = Color(0xFFF4F7FA);
  static const Color fillSubtle = Color(0xFFEDF3F7);

  static const Color infoBackground = Color(0xFFEAF4FB);
  static const Color infoForeground = Color(0xFF005B78);

  static const Color successBackground = Color(0xFFEAF7F0);
  static const Color successForeground = Color(0xFF1E7E4F);

  static const Color warningBackground = Color(0xFFFFF4E4);
  static const Color warningForeground = Color(0xFF9C5E00);

  static const Color dangerBackground = Color(0xFFFFECEB);
  static const Color dangerForeground = Color(0xFFB3261E);

  static const Color focusRing = Color(0x33006686);
}
