import 'package:flutter/material.dart';

import '../../../../core/common/layout/app_page_constraints.dart';
import '../../../../core/common/layout/app_page_padding.dart';
import '../../../../core/common/widgets/app_competition_card.dart';
import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_input_field.dart';
import '../../../../core/common/widgets/app_pill_button.dart';
import '../../../../core/common/widgets/app_section_card.dart';
import '../../../../core/common/widgets/app_section_header.dart';
import '../../../../core/common/widgets/app_stat_card.dart';
import '../../../../core/common/widgets/app_top_bar.dart';
import '../../../../core/constants/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_context_extension.dart';
import '../mock/competition_mock_data.dart';

class CompetitionPage extends StatefulWidget {
  const CompetitionPage({super.key});

  @override
  State<CompetitionPage> createState() => _CompetitionPageState();
}

class _CompetitionPageState extends State<CompetitionPage> {
  final TextEditingController _searchController = TextEditingController();

  CompetitionLevelFilter _selectedCategory = CompetitionLevelFilter.all;
  String _searchKeyword = '';

  List<RecommendedCompetitionData> get _filteredRecommendations {
    return CompetitionMockData.recommendations
        .where((competition) {
          final categoryMatched =
              _selectedCategory == CompetitionLevelFilter.all ||
              competition.level == _selectedCategory;
          if (!categoryMatched) {
            return false;
          }

          final keyword = _searchKeyword.trim();
          if (keyword.isEmpty) {
            return true;
          }

          final lowerKeyword = keyword.toLowerCase();
          return competition.title.toLowerCase().contains(lowerKeyword) ||
              competition.description.toLowerCase().contains(lowerKeyword);
        })
        .toList(growable: false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final contentWidth = availableWidth
            .clamp(0.0, AppPageConstraints.dashboard)
            .toDouble();
        final hasBottomNav = availableWidth < AppBreakpoints.tablet;
        final bottomPadding = hasBottomNav
            ? AppSizes.bottomNavHeight +
                  MediaQuery.paddingOf(context).bottom +
                  AppSpacing.xxl
            : AppSpacing.section;
        final statsCrossAxisCount =
            contentWidth >= CompetitionMockData.statsWideMinWidth ? 4 : 2;
        final recommendationCrossAxisCount =
            contentWidth >=
                CompetitionMockData.recommendationsThreeColumnMinWidth
            ? 3
            : contentWidth >=
                  CompetitionMockData.recommendationsTwoColumnMinWidth
            ? 2
            : 1;

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppPageConstraints.dashboard,
            ),
            child: ListView(
              padding: AppPagePadding.content(
                context,
                top: AppSpacing.lg,
                bottom: bottomPadding,
              ),
              children: [
                _CompetitionPageHeader(title: CompetitionMockData.pageTitle),
                const SizedBox(height: AppSpacing.lg),
                _SearchBarCard(
                  controller: _searchController,
                  onSearch: _performSearch,
                ),
                const SizedBox(height: AppSpacing.lg),
                _StatsGrid(crossAxisCount: statsCrossAxisCount),
                SizedBox(height: AppPagePadding.sectionGap(context)),
                _CategorySection(
                  selectedCategory: _selectedCategory,
                  onCategoryChanged: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                AppSectionHeader(
                  title: CompetitionMockData.recommendationSectionTitle,
                  actionLabel: CompetitionMockData.recommendationActionLabel,
                  onActionTap: () {},
                ),
                const SizedBox(height: AppSpacing.md),
                _RecommendationList(
                  crossAxisCount: recommendationCrossAxisCount,
                  items: _filteredRecommendations,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _performSearch() {
    FocusScope.of(context).unfocus();
    setState(() {
      _searchKeyword = _searchController.text;
    });
  }
}

class _CompetitionPageHeader extends StatelessWidget {
  const _CompetitionPageHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppTopBar(
      title: title,
      centerTitle: false,
      sideWidth: 36,
      height: AppSizes.appBarHeight + AppSpacing.sm,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      leading: const SizedBox.shrink(),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_none_rounded),
        color: context.colors.onSurfaceVariant,
      ),
    );
  }
}

class _SearchBarCard extends StatelessWidget {
  const _SearchBarCard({required this.controller, required this.onSearch});

  final TextEditingController controller;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: AppInputField(
              controller: controller,
              hintText: CompetitionMockData.searchHint,
              prefixIcon: Icon(
                Icons.search_rounded,
                color: context.colors.onSurfaceVariant,
              ),
              onChanged: (_) {},
              textInputAction: TextInputAction.search,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          AppPillButton(
            label: CompetitionMockData.searchButtonLabel,
            onPressed: onSearch,
            expanded: false,
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.crossAxisCount});

  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: CompetitionMockData.stats.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: CompetitionMockData.statsGridAspectRatio,
      ),
      itemBuilder: (context, index) {
        if (index == CompetitionMockData.stats.length) {
          return const _AddRecordStatCard();
        }

        final stat = CompetitionMockData.stats[index];
        return _StatValueCard(stat: stat);
      },
    );
  }
}

class _StatValueCard extends StatelessWidget {
  const _StatValueCard({required this.stat});

  final CompetitionStatData stat;

  @override
  Widget build(BuildContext context) {
    return AppStatCard(
      label: stat.label,
      value: stat.value,
      unit: stat.unit,
      accentColor: stat.accentColor,
      onTap: () {},
    );
  }
}

class _AddRecordStatCard extends StatelessWidget {
  const _AddRecordStatCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: () {},
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.15),
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_rounded,
                color: AppColors.primary,
                size: 22,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                CompetitionMockData.addRecordLabel,
                style: context.textStyles.labelLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final CompetitionLevelFilter selectedCategory;
  final ValueChanged<CompetitionLevelFilter> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(title: CompetitionMockData.categorySectionTitle),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final category in CompetitionMockData.categories)
              _CategoryChip(
                label: category.label,
                selected: category == selectedCategory,
                onTap: () => onCategoryChanged(category),
              ),
          ],
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primaryContainer.withValues(alpha: 0.22)
                : AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(
              color: selected
                  ? AppColors.primaryContainer.withValues(alpha: 0.2)
                  : AppColors.outlineVariant.withValues(alpha: 0.15),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            label,
            style: context.textStyles.labelLarge?.copyWith(
              color: selected
                  ? AppColors.onPrimaryContainer
                  : context.colors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _RecommendationList extends StatelessWidget {
  const _RecommendationList({
    required this.crossAxisCount,
    required this.items,
  });

  final int crossAxisCount;
  final List<RecommendedCompetitionData> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const AppSectionCard(
        child: AppEmptyState(
          title: CompetitionMockData.emptyStateTitle,
          description: CompetitionMockData.emptyStateDescription,
        ),
      );
    }

    if (crossAxisCount == 1) {
      return Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _RecommendedCompetitionCard(data: items[index]),
            if (index != items.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
        ],
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        mainAxisExtent: crossAxisCount == 2
            ? CompetitionMockData.recommendationsTwoColumnItemExtent
            : CompetitionMockData.recommendationsThreeColumnItemExtent,
      ),
      itemBuilder: (context, index) {
        return _RecommendedCompetitionCard(data: items[index]);
      },
    );
  }
}

class _RecommendedCompetitionCard extends StatelessWidget {
  const _RecommendedCompetitionCard({required this.data});

  final RecommendedCompetitionData data;

  @override
  Widget build(BuildContext context) {
    return AppCompetitionCard(
      levelLabel: data.level.label,
      title: data.title,
      description: data.description,
      deadline: data.deadline,
      teamInfo: data.teamInfo,
      headerColors: <Color>[data.headerStartColor, data.headerEndColor],
      primaryActionLabel: data.primaryActionLabel,
      secondaryActionLabel: data.secondaryActionLabel,
      onPrimaryTap: () {},
      onSecondaryTap: () {},
    );
  }
}
