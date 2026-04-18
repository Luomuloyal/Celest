import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_elevation.dart';
import 'app_radius.dart';
import 'app_sizes.dart';
import 'app_theme_extension.dart';
import 'app_theme_values.dart';
import 'app_text_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onPrimary,
      error: AppColors.error,
      onError: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      appTheme: AppThemeValues.light,
      scaffoldBackgroundColor: AppColors.background,
    );
  }

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF6BC7F2),
      onPrimary: Color(0xFF082B38),
      secondary: Color(0xFF86BBD8),
      onSecondary: Color(0xFF0E2531),
      error: Color(0xFFFF8B86),
      onError: Color(0xFF4F1210),
      surface: Color(0xFF0F161D),
      onSurface: Color(0xFFEAF1F7),
    );

    return _buildTheme(
      colorScheme: colorScheme,
      appTheme: AppThemeValues.dark,
      scaffoldBackgroundColor: const Color(0xFF0C1116),
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required AppThemeExtension appTheme,
    required Color scaffoldBackgroundColor,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      fontFamily: AppTextStyles.fontFamily,
      textTheme: const TextTheme(
        displaySmall: AppTextStyles.display,
        headlineMedium: AppTextStyles.headline,
        titleLarge: AppTextStyles.title,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.bodySecondary,
        labelLarge: AppTextStyles.label,
        bodySmall: AppTextStyles.caption,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface.withValues(alpha: 0.9),
        foregroundColor: colorScheme.onSurface,
        centerTitle: false,
        elevation: AppElevation.level0,
        scrolledUnderElevation: AppElevation.level1,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: AppSizes.appBarHeight,
      ),
      cardTheme: CardThemeData(
        color: appTheme.sectionBackground,
        elevation: AppElevation.level1,
        shadowColor: appTheme.sectionShadow,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: appTheme.inputBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
          borderSide: BorderSide(color: appTheme.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
          borderSide: BorderSide(color: appTheme.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.2),
        ),
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.56),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          elevation: AppElevation.level0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(color: appTheme.inputBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
        ),
      ),
      dividerColor: appTheme.sectionBorder,
      extensions: <ThemeExtension<dynamic>>[
        appTheme,
      ],
    );
  }
}
