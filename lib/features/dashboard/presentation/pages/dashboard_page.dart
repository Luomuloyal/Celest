import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/providers/app_service_providers.dart';
import '../../../../core/common/widgets/app_action_tile.dart';
import '../../../../core/common/widgets/app_competition_card.dart';
import '../../../../core/common/widgets/app_hero_banner.dart';
import '../../../../core/common/widgets/app_list_tile_card.dart';
import '../../../../core/common/widgets/app_page_scaffold.dart';
import '../../../../core/common/widgets/app_section_card.dart';
import '../../../../core/common/widgets/app_section_header.dart';
import '../../../../core/common/widgets/app_stat_card.dart';
import '../../../../core/common/widgets/app_timeline_item.dart';
import '../../../../core/common/widgets/app_top_bar.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_controller.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationService = ref.read(notificationServiceProvider);
    final themeController = ref.read(themeModeProvider.notifier);

    return AppPageScaffold(
      topBar: AppTopBar(
        leading: const CircleAvatar(
          radius: 16,
          child: Icon(Icons.person, size: 18),
        ),
        title: 'Celest',
        trailing: _TopBarActions(
          onThemeToggle: () => themeController.toggle(),
          onNotify: () {
            notificationService.showInfo('系统提醒', '你有 1 条新的竞赛动态待查看。');
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.section + 48,
        ),
        children: [
          AppHeroBanner(
            title: '欢迎回来, Alex',
            subtitle: '准备好迎接新的挑战了吗？你的项目进度良好，继续保持。',
            actionLabel: '查看我的工作台',
            actionIcon: Icons.arrow_forward,
            onActionTap: () {
              notificationService.showInfo('工作台', '工作台入口已准备好，后续接真实业务路由即可。');
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          const Row(
            children: [
              Expanded(
                child: AppStatCard(label: '待办任务', value: '12', unit: '项'),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppStatCard(
                  label: '活跃团队',
                  value: '3',
                  unit: '个',
                  accentColor: Color(0xFFF4A63F),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          const AppSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSectionHeader(title: '快捷操作'),
                SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: AppActionTile(
                          icon: Icons.app_registration,
                          label: '报名',
                        ),
                      ),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: AppActionTile(
                          icon: Icons.groups_2_outlined,
                          label: '组队',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: AppActionTile(
                          icon: Icons.smart_toy_outlined,
                          label: 'AI导师',
                          tint: Color(0xFFB27415),
                        ),
                      ),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: AppActionTile(
                          icon: Icons.folder_copy_outlined,
                          label: '资源',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppCompetitionCard(
            levelLabel: '国家级',
            title: '2024年全国大学生数学建模竞赛',
            description: '培养大学生的创新意识以及运用数学方法和计算机技术解决实际问题的能力。',
            deadline: DateTime(2024, 9, 1),
            countdown: const Duration(days: 12, hours: 8, minutes: 45),
            teamInfo: '组队要求: 3人/队',
            onPrimaryTap: () {
              notificationService.showInfo('报名提示', '这里后续接入真实报名流程。');
            },
            onSecondaryTap: () {
              notificationService.showInfo('赛事详情', '这里后续接入赛事详情页。');
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          const AppSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSectionHeader(title: '实时动态', actionLabel: '查看全部'),
                SizedBox(height: AppSpacing.lg),
                AppTimelineItem(
                  icon: Icons.celebration_outlined,
                  title: '团队“星火计划”成功晋级决赛',
                  subtitle: '10分钟前 · 全国创新挑战赛',
                ),
                AppTimelineItem(
                  icon: Icons.assignment_outlined,
                  title: '导师对项目方案提出了新建议',
                  subtitle: '2小时前 · 项目指导',
                ),
                AppTimelineItem(
                  icon: Icons.event_note_outlined,
                  title: '“数学乡村”赛道报名即将截止',
                  subtitle: '昨天 14:30 · 系统通知',
                  showConnector: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppListTileCard(
            icon: Icons.notifications_none_rounded,
            title: '通知设置',
            subtitle: '测试系统通知与应用内兜底通知链路',
            onTap: () {
              notificationService.showInfo('通知测试', '通知链路工作正常。');
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppListTileCard(
            icon: Icons.dark_mode_outlined,
            title: '切换主题',
            subtitle: '亮色 / 深色主题即时切换并持久化保存',
            onTap: () => themeController.toggle(),
          ),
        ],
      ),
    );
  }
}

class _TopBarActions extends StatelessWidget {
  const _TopBarActions({required this.onThemeToggle, required this.onNotify});

  final VoidCallback onThemeToggle;
  final VoidCallback onNotify;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ActionIconButton(
          icon: Icons.brightness_6_outlined,
          onTap: onThemeToggle,
        ),
        const SizedBox(width: AppSpacing.xs),
        _ActionIconButton(
          icon: Icons.notifications_none_rounded,
          onTap: onNotify,
        ),
      ],
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  const _ActionIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
