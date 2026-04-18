import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.pageGradientStart,
    required this.pageGradientEnd,
    required this.sectionBackground,
    required this.sectionBorder,
    required this.sectionShadow,
    required this.heroGradientStart,
    required this.heroGradientEnd,
    required this.pillBackground,
    required this.pillForeground,
    required this.pillMutedBackground,
    required this.pillMutedForeground,
    required this.inputBackground,
    required this.inputBorder,
    required this.tileBackground,
    required this.tilePressedBackground,
    required this.notificationSuccess,
    required this.notificationInfo,
  });

  final Color pageGradientStart;
  final Color pageGradientEnd;
  final Color sectionBackground;
  final Color sectionBorder;
  final Color sectionShadow;
  final Color heroGradientStart;
  final Color heroGradientEnd;
  final Color pillBackground;
  final Color pillForeground;
  final Color pillMutedBackground;
  final Color pillMutedForeground;
  final Color inputBackground;
  final Color inputBorder;
  final Color tileBackground;
  final Color tilePressedBackground;
  final Color notificationSuccess;
  final Color notificationInfo;

  @override
  AppThemeExtension copyWith({
    Color? pageGradientStart,
    Color? pageGradientEnd,
    Color? sectionBackground,
    Color? sectionBorder,
    Color? sectionShadow,
    Color? heroGradientStart,
    Color? heroGradientEnd,
    Color? pillBackground,
    Color? pillForeground,
    Color? pillMutedBackground,
    Color? pillMutedForeground,
    Color? inputBackground,
    Color? inputBorder,
    Color? tileBackground,
    Color? tilePressedBackground,
    Color? notificationSuccess,
    Color? notificationInfo,
  }) {
    return AppThemeExtension(
      pageGradientStart: pageGradientStart ?? this.pageGradientStart,
      pageGradientEnd: pageGradientEnd ?? this.pageGradientEnd,
      sectionBackground: sectionBackground ?? this.sectionBackground,
      sectionBorder: sectionBorder ?? this.sectionBorder,
      sectionShadow: sectionShadow ?? this.sectionShadow,
      heroGradientStart: heroGradientStart ?? this.heroGradientStart,
      heroGradientEnd: heroGradientEnd ?? this.heroGradientEnd,
      pillBackground: pillBackground ?? this.pillBackground,
      pillForeground: pillForeground ?? this.pillForeground,
      pillMutedBackground: pillMutedBackground ?? this.pillMutedBackground,
      pillMutedForeground: pillMutedForeground ?? this.pillMutedForeground,
      inputBackground: inputBackground ?? this.inputBackground,
      inputBorder: inputBorder ?? this.inputBorder,
      tileBackground: tileBackground ?? this.tileBackground,
      tilePressedBackground:
          tilePressedBackground ?? this.tilePressedBackground,
      notificationSuccess: notificationSuccess ?? this.notificationSuccess,
      notificationInfo: notificationInfo ?? this.notificationInfo,
    );
  }

  @override
  AppThemeExtension lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      pageGradientStart:
          Color.lerp(pageGradientStart, other.pageGradientStart, t)!,
      pageGradientEnd: Color.lerp(pageGradientEnd, other.pageGradientEnd, t)!,
      sectionBackground:
          Color.lerp(sectionBackground, other.sectionBackground, t)!,
      sectionBorder: Color.lerp(sectionBorder, other.sectionBorder, t)!,
      sectionShadow: Color.lerp(sectionShadow, other.sectionShadow, t)!,
      heroGradientStart:
          Color.lerp(heroGradientStart, other.heroGradientStart, t)!,
      heroGradientEnd: Color.lerp(heroGradientEnd, other.heroGradientEnd, t)!,
      pillBackground: Color.lerp(pillBackground, other.pillBackground, t)!,
      pillForeground: Color.lerp(pillForeground, other.pillForeground, t)!,
      pillMutedBackground:
          Color.lerp(pillMutedBackground, other.pillMutedBackground, t)!,
      pillMutedForeground:
          Color.lerp(pillMutedForeground, other.pillMutedForeground, t)!,
      inputBackground:
          Color.lerp(inputBackground, other.inputBackground, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      tileBackground: Color.lerp(tileBackground, other.tileBackground, t)!,
      tilePressedBackground:
          Color.lerp(tilePressedBackground, other.tilePressedBackground, t)!,
      notificationSuccess:
          Color.lerp(notificationSuccess, other.notificationSuccess, t)!,
      notificationInfo:
          Color.lerp(notificationInfo, other.notificationInfo, t)!,
    );
  }
}
