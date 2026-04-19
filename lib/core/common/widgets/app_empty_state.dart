import 'package:flutter/material.dart';

import '../layout/app_page_constraints.dart';
import '../layout/app_page_padding.dart';
import '../../theme/app_semantic_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_context_extension.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    this.icon = Icons.inbox_outlined,
    this.title = '暂无内容',
    this.description = '数据准备好后会显示在这里。',
    this.actionLabel,
    this.onAction,
    this.fullscreen = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;
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
              decoration: BoxDecoration(
                color: AppSemanticColors.infoBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 28,
                color: AppSemanticColors.infoForeground,
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
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
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
