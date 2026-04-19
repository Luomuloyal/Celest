import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ProfileBadgeData {
  const ProfileBadgeData({required this.label});

  final String label;
}

class ProfileAssetSummaryData {
  const ProfileAssetSummaryData({
    required this.pointsValue,
    required this.pointsLabel,
    required this.couponValue,
    required this.couponLabel,
    required this.actionLabel,
  });

  final String pointsValue;
  final String pointsLabel;
  final String couponValue;
  final String couponLabel;
  final String actionLabel;
}

class ProfileArchiveData {
  const ProfileArchiveData({
    required this.statusLabel,
    required this.dateLabel,
    required this.title,
    required this.description,
    required this.footerLabel,
    required this.footerIcon,
    required this.highlight,
  });

  final String statusLabel;
  final String dateLabel;
  final String title;
  final String description;
  final String footerLabel;
  final IconData footerIcon;
  final bool highlight;
}

class ProfileSettingItemData {
  const ProfileSettingItemData({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

abstract final class ProfileMockData {
  static const double heroSplitMinWidth = 840;
  static const double archiveSplitMinWidth = 760;
  static const double profileAvatarSize = 96;
  static const double profileBadgeSpacing = 8;

  static const String appTitle = '赛育通';
  static const String displayName = '张伟 (Zhang Wei)';
  static const String profileSubTitle = '清华大学 | 计算机科学与技术系';
  static const String avatarUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAn0LWGqFfOoq7-MIM0dV2QJJc-uX2VcSjX11MZDrP-aDPqvpDeEkzRRtiCisefhN_H1KCjO88aEoVGsCNtG9G6zwfmGKY11PaxS4dKs-hOoeH7cb7ze1QhpYQ2fRLUz1BULAqnLf8n2ON5x32MDt-MctnUY9zqY0uVetZd_rpJ5TI3Fre8VBkkZur6ksjArXcZqwlgnVXYK6l5NPqZEhs08oneWRIcU6yticFRwcRGQ2H5GFKMpIvPhZ48TFAhuNRqH0hZdAt4toEx';

  static const List<ProfileBadgeData> badges = <ProfileBadgeData>[
    ProfileBadgeData(label: '指导教师'),
    ProfileBadgeData(label: '高级认证'),
  ];

  static const String assetSectionTitle = '我的资产';
  static const ProfileAssetSummaryData assets = ProfileAssetSummaryData(
    pointsValue: '1,250',
    pointsLabel: '积分余额',
    couponValue: '3',
    couponLabel: '优惠券',
    actionLabel: '去兑换',
  );

  static const String archiveSectionTitle = '竞赛档案';
  static const List<ProfileArchiveData> archives = <ProfileArchiveData>[
    ProfileArchiveData(
      statusLabel: '进行中',
      dateLabel: '2023-11 至今',
      title: '全国大学生人工智能挑战赛',
      description: '指导项目《基于深度学习的智能医疗辅助诊断系统》进入全国总决赛。',
      footerLabel: '查看详情',
      footerIcon: Icons.arrow_forward_ios_rounded,
      highlight: true,
    ),
    ProfileArchiveData(
      statusLabel: '已完结',
      dateLabel: '2023-05',
      title: '"创青春"全国大学生创业大赛',
      description: '指导团队荣获全国银奖，项目成果已成功孵化。',
      footerLabel: '查看证书',
      footerIcon: Icons.workspace_premium_outlined,
      highlight: false,
    ),
  ];

  static const String settingsSectionTitle = '设置与帮助';
  static const List<ProfileSettingItemData> settingsItems =
      <ProfileSettingItemData>[
        ProfileSettingItemData(
          title: '消息通知',
          icon: Icons.notifications_active_outlined,
        ),
        ProfileSettingItemData(title: '账号与安全', icon: Icons.shield_outlined),
        ProfileSettingItemData(
          title: '帮助与反馈',
          icon: Icons.help_outline_rounded,
        ),
      ];
  static const String logoutLabel = '退出登录';

  static const Color heroGlowStart = AppColors.primary;
  static const Color heroGlowEnd = AppColors.primaryContainer;
}
