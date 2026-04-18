import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';

class AppPlaceholderPage extends StatelessWidget {
  const AppPlaceholderPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: context.textStyles.headlineMedium?.copyWith(
              fontSize: 28,
              color: context.colors.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '$title 页面占位',
            style: context.textStyles.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
