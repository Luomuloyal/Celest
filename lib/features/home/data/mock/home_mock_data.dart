import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class HomeHeroContent {
  const HomeHeroContent({
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.gradientColors,
  });

  final String title;
  final String subtitle;
  final String actionLabel;
  final List<Color> gradientColors;
}

class HomeCountdownContent {
  const HomeCountdownContent({
    required this.statusLabel,
    required this.title,
    required this.subtitle,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.daysUnitLabel,
    required this.hoursUnitLabel,
    required this.minutesUnitLabel,
    required this.separatorLabel,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
  });

  final String statusLabel;
  final String title;
  final String subtitle;
  final String days;
  final String hours;
  final String minutes;
  final String daysUnitLabel;
  final String hoursUnitLabel;
  final String minutesUnitLabel;
  final String separatorLabel;
  final String primaryActionLabel;
  final String secondaryActionLabel;
}

class HomeQuickActionData {
  const HomeQuickActionData({
    required this.icon,
    required this.label,
    required this.tint,
  });

  final IconData icon;
  final String label;
  final Color tint;
}

class HomeLiveUpdateData {
  const HomeLiveUpdateData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.showConnector,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color tint;
  final bool showConnector;
}

class HomeBenchmarkCaseContent {
  const HomeBenchmarkCaseContent({
    required this.categoryLabel,
    required this.badgeLabel,
    required this.title,
    required this.description,
    required this.teamLabel,
    required this.imageUrl,
    required this.avatarUrl,
  });

  final String categoryLabel;
  final String badgeLabel;
  final String title;
  final String description;
  final String teamLabel;
  final String imageUrl;
  final String avatarUrl;
}

abstract final class HomeMockData {
  static const double primarySplitMinWidth = 900;
  static const double secondarySplitMinWidth = 840;
  static const double heroCompactMaxWidth = 560;
  static const double heroTitleScaleFactor = 0.05;
  static const double heroTitleMinSize = 34;
  static const double heroTitleMaxSize = 60;
  static const double heroSubtitleScaleFactor = 0.019;
  static const double heroSubtitleMinSize = 16;
  static const double heroSubtitleMaxSize = 23;
  static const double quickActionCompactMaxWidth = 340;
  static const double quickActionAspectRatio = 1.06;

  static const String quickActionTitle = '快捷操作';
  static const String liveUpdateTitle = '实时动态';
  static const String liveUpdateActionLabel = '查看全部';
  static const String benchmarkTitle = '标杆案例';

  static const HomeHeroContent hero = HomeHeroContent(
    title: '欢迎回来, Alex',
    subtitle: '准备好迎接新的挑战了吗？你的项目进度良好，继续保持。',
    actionLabel: '查看我的工作台',
    gradientColors: <Color>[Color(0xFF1B7BA5), Color(0xFF6BC7F2)],
  );

  static const HomeCountdownContent countdown = HomeCountdownContent(
    statusLabel: '报名中',
    title: '全国创新挑战赛',
    subtitle: '2024年度科技赛道省级复赛',
    days: '12',
    hours: '08',
    minutes: '45',
    daysUnitLabel: '天',
    hoursUnitLabel: '小时',
    minutesUnitLabel: '分钟',
    separatorLabel: ':',
    primaryActionLabel: '立即提交作品',
    secondaryActionLabel: '查看详情',
  );

  static const List<HomeQuickActionData> quickActions =
      <HomeQuickActionData>[
        HomeQuickActionData(
          icon: Icons.app_registration_rounded,
          label: '报名',
          tint: AppColors.primary,
        ),
        HomeQuickActionData(
          icon: Icons.groups_2_outlined,
          label: '组队',
          tint: AppColors.secondary,
        ),
        HomeQuickActionData(
          icon: Icons.smart_toy_outlined,
          label: 'AI导师',
          tint: AppColors.tertiary,
        ),
        HomeQuickActionData(
          icon: Icons.library_books_outlined,
          label: '资源',
          tint: AppColors.primary,
        ),
      ];

  static const List<HomeLiveUpdateData> liveUpdates =
      <HomeLiveUpdateData>[
        HomeLiveUpdateData(
          icon: Icons.celebration_outlined,
          title: '团队 "星火计划" 成功晋级决赛',
          subtitle: '10分钟前 · 全国创新挑战赛',
          tint: AppColors.primary,
          showConnector: true,
        ),
        HomeLiveUpdateData(
          icon: Icons.assignment_outlined,
          title: '导师李华对您的项目方案提出了新建议',
          subtitle: '2小时前 · 项目指导',
          tint: AppColors.secondary,
          showConnector: true,
        ),
        HomeLiveUpdateData(
          icon: Icons.event_note_outlined,
          title: '"数字乡村" 赛道报名即将截止',
          subtitle: '昨天 14:30 · 系统通知',
          tint: AppColors.tertiary,
          showConnector: false,
        ),
      ];

  static const HomeBenchmarkCaseContent
  benchmarkCase = HomeBenchmarkCaseContent(
    categoryLabel: 'AI科技赛道',
    badgeLabel: '2023年度金奖作品',
    title: '基于深度学习的智能生态监测系统',
    description: '该项目通过部署低功耗边缘计算节点，结合深度学习算法，实现对自然保护区内珍稀物种的实时监测与行为分析。',
    teamLabel: '由 "生态先锋" 团队主导',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBh82ly6GbsLjWs8ScWiCWDvQnRSDpttIGKNXAzazWAVS57UNSs_0NKcUWPz9WeIYriYo_tPG7drPKP4zuOfkWLc89x6-MXSRBIR46g0hKPmQ0oNlfS3Sej7M7_KSyWsPV-pNOYYIbGF4U39O5_tUc_gJiB2sMYXMslI67f8vWKOhmxj44gxj-ZkEF8W2SOBKwhvxk1ovKWmfyccJ7tQzoxBkTnaVtwQAG50umzEBAo4Ctpy3dDm55qP3OyK6Ty2QvK-fs1PuPEMVCp',
    avatarUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBuE_UmfVeWT2m-SQGWYacv20eY_u4PxANGEU-hmwwSj9KPORbL2-jFMbOxcsXhR7GNuYSdvkxkJFrQ2-G9nPqm3_69b28Ucq4zmlhAQy4XjfGr79gKHKg02eAzgSVZraO0yV7M_OUkHRLTct73EDD3EumAWX8gqIYY2X4gH1LAP86o2UXbZxlNeb8Ah-3Iwn04fR-euXG5KtUAgZu9isL5JYxXR0Hg5jcszLAxea16k_EEdwGf48ltbF90r-IFzRcFINTqehXgh8xz',
  );
}

