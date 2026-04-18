import 'package:flutter/material.dart';

import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';

class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: appTheme.sectionBackground,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: appTheme.sectionBorder),
        boxShadow: [
          BoxShadow(
            color: appTheme.sectionShadow,
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
