import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static const String fontFamily = 'Inter';
  static const String fallbackFontFamily = 'Noto Sans SC';

  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: <String>[fallbackFontFamily],
    fontSize: 32,
    height: 1.15,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.7,
    color: AppColors.onSurface,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: <String>[fallbackFontFamily],
    fontSize: 24,
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: AppColors.onSurface,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: <String>[fallbackFontFamily],
    fontSize: 18,
    height: 1.33,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: <String>[fallbackFontFamily],
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: <String>[fallbackFontFamily],
    fontSize: 15,
    height: 1.6,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: <String>[fallbackFontFamily],
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: <String>[fallbackFontFamily],
    fontSize: 12,
    height: 1.4,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceVariant,
  );
}
