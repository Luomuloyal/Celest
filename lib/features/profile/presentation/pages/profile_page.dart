import 'package:flutter/material.dart';

import '../../../../core/common/layout/app_page_constraints.dart';
import '../../../../core/common/layout/app_page_padding.dart';
import '../../../../core/common/widgets/app_pill.dart';
import '../../../../core/common/widgets/app_pill_button.dart';
import '../../../../core/common/widgets/app_section_card.dart';
import '../../../../core/common/widgets/app_section_header.dart';
import '../../../../core/common/widgets/app_top_bar.dart';
import '../../../../core/constants/app_breakpoints.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_context_extension.dart';
import '../mock/profile_mock_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final contentWidth = availableWidth
            .clamp(0.0, AppPageConstraints.dashboard)
            .toDouble();
        final showHeroSplit = contentWidth >= ProfileMockData.heroSplitMinWidth;
        final showArchiveSplit =
            contentWidth >= ProfileMockData.archiveSplitMinWidth;
        final hasBottomNav = availableWidth < AppBreakpoints.tablet;
        final bottomPadding = hasBottomNav
            ? AppSizes.bottomNavHeight +
                  MediaQuery.paddingOf(context).bottom +
                  AppSpacing.xxl
            : AppSpacing.section;

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
                const _ProfileHeader(),
                const SizedBox(height: AppSpacing.md),
                if (showHeroSplit)
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _ProfileInfoCard()),
                      SizedBox(width: AppSpacing.md),
                      Expanded(child: _ProfileAssetsCard()),
                    ],
                  )
                else
                  const Column(
                    children: [
                      _ProfileInfoCard(),
                      SizedBox(height: AppSpacing.md),
                      _ProfileAssetsCard(),
                    ],
                  ),
                SizedBox(height: AppPagePadding.sectionGap(context)),
                const AppSectionHeader(
                  title: ProfileMockData.archiveSectionTitle,
                ),
                const SizedBox(height: AppSpacing.md),
                _ProfileArchiveSection(split: showArchiveSplit),
                SizedBox(height: AppPagePadding.sectionGap(context)),
                const _ProfileSettingsCard(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return AppTopBar(
      title: ProfileMockData.appTitle,
      height: AppSizes.appBarHeight + AppSpacing.sm,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.full),
        child: Image.network(
          ProfileMockData.avatarUrl,
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

class _ProfileInfoCard extends StatelessWidget {
  const _ProfileInfoCard();

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: Stack(
        children: [
          Positioned(
            right: -64,
            top: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ProfileMockData.heroGlowStart.withValues(alpha: 0.2),
                    ProfileMockData.heroGlowEnd.withValues(alpha: 0.2),
                  ],
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: ProfileMockData.profileAvatarSize,
                height: ProfileMockData.profileAvatarSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(color: AppColors.surface, width: 4),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  ProfileMockData.avatarUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ProfileMockData.displayName,
                      style: context.textStyles.displaySmall?.copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      ProfileMockData.profileSubTitle,
                      style: context.textStyles.bodyMedium?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: ProfileMockData.profileBadgeSpacing,
                      runSpacing: ProfileMockData.profileBadgeSpacing,
                      children: [
                        for (final badge in ProfileMockData.badges)
                          AppPill(label: badge.label),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileAssetsCard extends StatelessWidget {
  const _ProfileAssetsCard();

  @override
  Widget build(BuildContext context) {
    final assets = ProfileMockData.assets;

    return AppSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  ProfileMockData.assetSectionTitle,
                  style: context.textStyles.labelLarge?.copyWith(
                    color: context.colors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.account_balance_wallet_rounded,
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            assets.pointsValue,
            style: context.textStyles.displaySmall?.copyWith(
              fontSize: 56,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            assets.pointsLabel,
            style: context.textStyles.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assets.couponValue,
                    style: context.textStyles.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    assets.couponLabel,
                    style: context.textStyles.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              AppPillButton(label: assets.actionLabel, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileArchiveSection extends StatelessWidget {
  const _ProfileArchiveSection({required this.split});

  final bool split;

  @override
  Widget build(BuildContext context) {
    final archives = ProfileMockData.archives;

    if (split && archives.length >= 2) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _ProfileArchiveCard(data: archives[0])),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: _ProfileArchiveCard(data: archives[1])),
        ],
      );
    }

    return Column(
      children: [
        for (var index = 0; index < archives.length; index++) ...[
          _ProfileArchiveCard(data: archives[index]),
          if (index != archives.length - 1)
            const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class _ProfileArchiveCard extends StatelessWidget {
  const _ProfileArchiveCard({required this.data});

  final ProfileArchiveData data;

  @override
  Widget build(BuildContext context) {
    final accentColor = data.highlight
        ? AppColors.primaryFixed
        : AppColors.surfaceContainerHighest;

    return AppSectionCard(
      child: Stack(
        children: [
          Positioned(
            left: -AppSpacing.lg,
            top: 0,
            bottom: 0,
            child: Container(width: 3, color: accentColor),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppPill(label: data.statusLabel, tinted: data.highlight),
                  const Spacer(),
                  Text(
                    data.dateLabel,
                    style: context.textStyles.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
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
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                data.description,
                style: context.textStyles.bodyMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Text(
                    data.footerLabel,
                    style: context.textStyles.labelLarge?.copyWith(
                      color: data.highlight
                          ? AppColors.primary
                          : context.colors.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    data.footerIcon,
                    size: AppSizes.iconSm,
                    color: data.highlight
                        ? AppColors.primary
                        : context.colors.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileSettingsCard extends StatelessWidget {
  const _ProfileSettingsCard();

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(title: ProfileMockData.settingsSectionTitle),
          const SizedBox(height: AppSpacing.md),
          for (
            var index = 0;
            index < ProfileMockData.settingsItems.length;
            index++
          )
            Padding(
              padding: EdgeInsets.only(
                bottom: index == ProfileMockData.settingsItems.length - 1
                    ? 0
                    : AppSpacing.smPlus,
              ),
              child: _ProfileSettingRow(
                item: ProfileMockData.settingsItems[index],
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          AppPillButton(
            label: ProfileMockData.logoutLabel,
            variant: AppPillButtonVariant.muted,
            expanded: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ProfileSettingRow extends StatelessWidget {
  const _ProfileSettingRow({required this.item});

  final ProfileSettingItemData item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.smPlus,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                alignment: Alignment.center,
                child: Icon(item.icon, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(item.title, style: context.textStyles.bodyLarge),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.outlineVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
