import 'package:flutter/material.dart';

import '../layout/app_page_constraints.dart';
import '../layout/app_page_padding.dart';
import '../../theme/app_semantic_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';

class AppLoadingState extends StatelessWidget {
  const AppLoadingState({
    super.key,
    this.title = '正在加载',
    this.description,
    this.fullscreen = false,
    this.compact = false,
  });

  final String title;
  final String? description;
  final bool fullscreen;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final body = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppPageConstraints.state),
      child: Padding(
        padding: fullscreen
            ? AppPagePadding.content(context)
            : EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
            SizedBox(height: compact ? AppSpacing.smPlus : AppSpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textStyles.titleLarge?.copyWith(
                color: AppSemanticColors.textPrimary,
              ),
            ),
            if (description != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: context.textStyles.bodyMedium?.copyWith(
                  color: AppSemanticColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    if (fullscreen) {
      return Center(child: body);
    }

    return body;
  }
}
