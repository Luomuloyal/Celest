import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../layout/app_page_constraints.dart';
import '../layout/app_page_padding.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_semantic_colors.dart';
import '../../theme/theme_context_extension.dart';

class AppPlaceholderPage extends StatelessWidget {
  const AppPlaceholderPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPagePadding.content(context),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppPageConstraints.state),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: context.textStyles.headlineMedium?.copyWith(
                  fontSize: 28,
                  color: AppSemanticColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                context.l10n.pagePlaceholder(title),
                style: context.textStyles.bodyMedium?.copyWith(
                  color: AppSemanticColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
