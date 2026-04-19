import 'package:flutter/material.dart';

import '../layout/app_page_constraints.dart';
import '../layout/app_page_padding.dart';
import '../../theme/app_semantic_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    this.title = '出了点问题',
    this.description = '请稍后重试，或检查当前网络连接。',
    this.retryLabel,
    this.onRetry,
    this.fullscreen = false,
  });

  final String title;
  final String description;
  final String? retryLabel;
  final VoidCallback? onRetry;
  final bool fullscreen;

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
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppSemanticColors.dangerBackground,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 28,
                color: AppSemanticColors.dangerForeground,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textStyles.titleLarge?.copyWith(
                color: AppSemanticColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              description,
              textAlign: TextAlign.center,
              style: context.textStyles.bodyMedium?.copyWith(
                color: AppSemanticColors.textSecondary,
              ),
            ),
            if (retryLabel != null && onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(
                onPressed: onRetry,
                child: Text(retryLabel!),
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
