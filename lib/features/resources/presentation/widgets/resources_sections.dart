import 'package:flutter/material.dart';

import '../../../../core/common/layout/app_page_constraints.dart';
import '../../../../core/common/layout/app_page_padding.dart';
import '../../../../core/common/widgets/app_empty_state.dart';
import '../../../../core/common/widgets/app_pill.dart';
import '../../../../core/common/widgets/app_pill_button.dart';
import '../../../../core/common/widgets/app_section_card.dart';
import '../../../../core/common/widgets/app_section_header.dart';
import '../../../../core/common/widgets/app_timeline_item.dart';
import '../../../../core/common/widgets/app_top_bar.dart';
import '../../../../core/constants/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_context_extension.dart';
import '../../data/mock/resources_mock_data.dart';

class ResourcesSections extends StatefulWidget {
  const ResourcesSections({super.key});

  @override
  State<ResourcesSections> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesSections> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';

  List<ResourceCategoryData> get _filteredCategories {
    final keyword = _searchKeyword.trim().toLowerCase();
    if (keyword.isEmpty) {
      return ResourcesMockData.categories;
    }

    return ResourcesMockData.categories
        .where((category) {
          final tags = category.tags.join(' ');
          return category.title.toLowerCase().contains(keyword) ||
              category.description.toLowerCase().contains(keyword) ||
              tags.toLowerCase().contains(keyword);
        })
        .toList(growable: false);
  }

  List<ResourceAchievementData> get _filteredShowcases {
    final keyword = _searchKeyword.trim().toLowerCase();
    if (keyword.isEmpty) {
      return ResourcesMockData.showcases;
    }

    return ResourcesMockData.showcases
        .where((item) {
          return item.title.toLowerCase().contains(keyword) ||
              item.description.toLowerCase().contains(keyword) ||
              item.label.toLowerCase().contains(keyword);
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
        final categoryCrossAxisCount =
            contentWidth >= ResourcesMockData.categoryThreeColumnMinWidth
            ? 3
            : contentWidth >= ResourcesMockData.categoryTwoColumnMinWidth
            ? 2
            : 1;
        final showcaseCrossAxisCount =
            contentWidth >= ResourcesMockData.showcaseThreeColumnMinWidth
            ? 3
            : contentWidth >= ResourcesMockData.showcaseTwoColumnMinWidth
            ? 2
            : 1;
        final compactPath =
            contentWidth < ResourcesMockData.compactPathMaxWidth;

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
                const _ResourcesHeader(),
                const SizedBox(height: AppSpacing.md),
                _HeroSearchCard(
                  controller: _searchController,
                  onSearch: _performSearch,
                ),
                SizedBox(height: AppPagePadding.sectionGap(context)),
                _CategorySection(
                  categories: _filteredCategories,
                  crossAxisCount: categoryCrossAxisCount,
                ),
                SizedBox(height: AppPagePadding.sectionGap(context)),
                _SuccessPathSection(compact: compactPath),
                SizedBox(height: AppPagePadding.sectionGap(context)),
                _ShowcaseSection(
                  items: _filteredShowcases,
                  crossAxisCount: showcaseCrossAxisCount,
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

class _ResourcesHeader extends StatelessWidget {
  const _ResourcesHeader();

  @override
  Widget build(BuildContext context) {
    return AppTopBar(
      title: ResourcesMockData.appTitle,
      height: AppSizes.appBarHeight + AppSpacing.sm,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.full),
        child: Image.network(
          ResourcesMockData.avatarUrl,
          width: 32,
          height: 32,
          fit: BoxFit.cover,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_none_rounded),
        color: AppColors.primary,
      ),
    );
  }
}

class _HeroSearchCard extends StatelessWidget {
  const _HeroSearchCard({required this.controller, required this.onSearch});

  final TextEditingController controller;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryContainer],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -72,
            right: -42,
            child: _HeroGlow(
              size: 240,
              color: AppColors.surfaceContainerLowest.withValues(alpha: 0.22),
            ),
          ),
          Positioned(
            bottom: -68,
            left: -40,
            child: _HeroGlow(
              size: 180,
              color: AppColors.primaryFixed.withValues(alpha: 0.35),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.xlMinus,
            ),
            child: Column(
              children: [
                Text(
                  ResourcesMockData.heroTitle,
                  style: context.textStyles.displaySmall?.copyWith(
                    color: AppColors.onPrimary,
                    fontSize: 46,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  ResourcesMockData.heroSubtitle,
                  style: context.textStyles.bodyMedium?.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.82),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.smPlus,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: AppColors.primary,
                        size: AppSizes.iconMd,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          onSubmitted: (_) => onSearch(),
                          style: context.textStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: ResourcesMockData.searchHint,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            hintStyle: context.textStyles.bodySmall?.copyWith(
                              color: context.colors.onSurfaceVariant.withValues(
                                alpha: 0.75,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      AppPillButton(
                        label: ResourcesMockData.searchButtonLabel,
                        onPressed: onSearch,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroGlow extends StatelessWidget {
  const _HeroGlow({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(color: color, blurRadius: 72, spreadRadius: 20),
          ],
        ),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.categories,
    required this.crossAxisCount,
  });

  final List<ResourceCategoryData> categories;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _AccentTitle(title: ResourcesMockData.categorySectionTitle),
        const SizedBox(height: AppSpacing.md),
        if (categories.isEmpty)
          const AppSectionCard(
            child: AppEmptyState(
              title: ResourcesMockData.categoryEmptyTitle,
              description: ResourcesMockData.categoryEmptyDescription,
            ),
          )
        else if (crossAxisCount == 1)
          Column(
            children: [
              for (var index = 0; index < categories.length; index++) ...[
                _CategoryCard(data: categories[index]),
                if (index != categories.length - 1)
                  const SizedBox(height: AppSpacing.md),
              ],
            ],
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              mainAxisExtent: ResourcesMockData.categoryGridItemExtent,
            ),
            itemBuilder: (context, index) {
              return _CategoryCard(data: categories[index]);
            },
          ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.data});

  final ResourceCategoryData data;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: Stack(
        children: [
          Positioned(
            right: -44,
            top: -40,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: data.tint.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: data.tint.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                alignment: Alignment.center,
                child: Icon(data.icon, color: data.tint),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                data.title,
                style: context.textStyles.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                data.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textStyles.bodyMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final tag in data.tags)
                    AppPill(label: tag, tinted: false),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuccessPathSection extends StatelessWidget {
  const _SuccessPathSection({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.surfaceContainerLow, AppColors.surface],
          ),
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xlMinus),
          child: Column(
            children: [
              AppPill(label: ResourcesMockData.pathBadge, tinted: false),
              const SizedBox(height: AppSpacing.md),
              Text(
                ResourcesMockData.pathTitle,
                style: context.textStyles.displaySmall?.copyWith(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                ResourcesMockData.pathDescription,
                style: context.textStyles.bodyMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              if (compact)
                Column(
                  children: [
                    for (
                      var index = 0;
                      index < ResourcesMockData.pathSteps.length;
                      index++
                    )
                      AppTimelineItem(
                        icon: ResourcesMockData.pathSteps[index].icon,
                        title:
                            '${ResourcesMockData.pathSteps[index].title}${ResourcesMockData.pathCompactTitleSeparator}${ResourcesMockData.pathSteps[index].badge}',
                        subtitle:
                            ResourcesMockData.pathSteps[index].description,
                        tint: ResourcesMockData.pathSteps[index].tint,
                        showConnector:
                            index != ResourcesMockData.pathSteps.length - 1,
                      ),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (
                      var index = 0;
                      index < ResourcesMockData.pathSteps.length;
                      index++
                    ) ...[
                      Expanded(
                        child: _PathStepCard(
                          data: ResourcesMockData.pathSteps[index],
                        ),
                      ),
                      if (index != ResourcesMockData.pathSteps.length - 1)
                        const SizedBox(width: AppSpacing.md),
                    ],
                  ],
                ),
              const SizedBox(height: AppSpacing.xlMinus),
              AppPillButton(
                label: ResourcesMockData.pathActionLabel,
                icon: Icons.trending_flat_rounded,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PathStepCard extends StatelessWidget {
  const _PathStepCard({required this.data});

  final ResourcePathStepData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              alignment: Alignment.center,
              child: Icon(
                data.icon,
                color: data.tint,
                size: AppSizes.iconLg + 6,
              ),
            ),
            Positioned(
              right: -6,
              bottom: -6,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: data.tint,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                alignment: Alignment.center,
                child: Text(
                  data.orderLabel,
                  style: context.textStyles.bodySmall?.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          data.title,
          style: context.textStyles.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          data.badge,
          style: context.textStyles.bodySmall?.copyWith(color: data.tint),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          data.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: context.textStyles.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ShowcaseSection extends StatelessWidget {
  const _ShowcaseSection({required this.items, required this.crossAxisCount});

  final List<ResourceAchievementData> items;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _AccentTitle(
          title: ResourcesMockData.showcaseSectionTitle,
          actionLabel: ResourcesMockData.showcaseActionLabel,
        ),
        const SizedBox(height: AppSpacing.md),
        if (items.isEmpty)
          const AppSectionCard(
            child: AppEmptyState(
              title: ResourcesMockData.showcaseEmptyTitle,
              description: ResourcesMockData.showcaseEmptyDescription,
            ),
          )
        else if (crossAxisCount == 1)
          Column(
            children: [
              for (var index = 0; index < items.length; index++) ...[
                _ShowcaseCard(data: items[index]),
                if (index != items.length - 1)
                  const SizedBox(height: AppSpacing.md),
              ],
            ],
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              mainAxisExtent: ResourcesMockData.showcaseGridItemExtent,
            ),
            itemBuilder: (context, index) {
              return _ShowcaseCard(data: items[index]);
            },
          ),
      ],
    );
  }
}

class _ShowcaseCard extends StatelessWidget {
  const _ShowcaseCard({required this.data});

  final ResourceAchievementData data;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(data.imageUrl, fit: BoxFit.cover),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.smPlus,
                    bottom: AppSpacing.smPlus,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: data.labelTint.withValues(alpha: 0.88),
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                      ),
                      child: Text(
                        data.label,
                        style: context.textStyles.bodySmall?.copyWith(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: context.textStyles.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      data.description,
                      style: context.textStyles.bodySmall?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility_outlined,
                          size: AppSizes.iconSm,
                          color: context.colors.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          data.views,
                          style: context.textStyles.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Icon(
                          Icons.thumb_up_alt_outlined,
                          size: AppSizes.iconSm,
                          color: context.colors.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          data.likes,
                          style: context.textStyles.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccentTitle extends StatelessWidget {
  const _AccentTitle({required this.title, this.actionLabel});

  final String title;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.primaryFixed,
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: AppSectionHeader(
            title: title,
            actionLabel: actionLabel,
            onActionTap: () {},
          ),
        ),
      ],
    );
  }
}

