import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ResourceCategoryData {
  const ResourceCategoryData({
    required this.icon,
    required this.title,
    required this.description,
    required this.tags,
    required this.tint,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<String> tags;
  final Color tint;
}

class ResourcePathStepData {
  const ResourcePathStepData({
    required this.icon,
    required this.title,
    required this.badge,
    required this.description,
    required this.tint,
    required this.orderLabel,
  });

  final IconData icon;
  final String title;
  final String badge;
  final String description;
  final Color tint;
  final String orderLabel;
}

class ResourceAchievementData {
  const ResourceAchievementData({
    required this.label,
    required this.title,
    required this.description,
    required this.views,
    required this.likes,
    required this.imageUrl,
    required this.labelTint,
  });

  final String label;
  final String title;
  final String description;
  final String views;
  final String likes;
  final String imageUrl;
  final Color labelTint;
}

abstract final class ResourcesMockData {
  static const double categoryThreeColumnMinWidth = 960;
  static const double categoryTwoColumnMinWidth = 680;
  static const double showcaseThreeColumnMinWidth = 1020;
  static const double showcaseTwoColumnMinWidth = 700;
  static const double compactPathMaxWidth = 760;
  static const double categoryGridItemExtent = 252;
  static const double showcaseGridItemExtent = 328;

  static const String appTitle = '赛育通';
  static const String avatarUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuATV-H9fzT0vYsR1fDh7qgataFrS5retd_9QARM3bWuEq9Aip7sma9OcszfZpLyK4KhvqoXTIWG6VGUoF9PCzpN6rv1oPNsa-NjdBmL76ld4W7p3tFCCeu0Zy9igF0woI7wBF8Y1XZzul4HXePWwql2yxLbmAVCTyAEOu3VhgpDCfk1QtdJKB-YcDfQ8QVJnNAZXuq66Gj0mTAEUEj4pBkrfMFu0qXoBEQHzX6yQMgPsp-3kIGN3hwdMoAtNovPx0TDLrNJhsw8jTzP';

  static const String heroTitle = '探索无限学习资源';
  static const String heroSubtitle = '从历年真题到前沿AI辅导，为您提供全方位的备赛与学习支持。';
  static const String searchHint = '搜索历年真题、案例分析或AI辅导资料...';
  static const String searchButtonLabel = '搜索';

  static const String categorySectionTitle = '核心资源分类';
  static const List<ResourceCategoryData> categories = <ResourceCategoryData>[
    ResourceCategoryData(
      icon: Icons.description_outlined,
      title: '历年考卷',
      description: '收录各大学科竞赛历年真题，提供详细解析与得分点梳理。',
      tags: <String>['数学竞赛', '物理奥赛'],
      tint: AppColors.primary,
    ),
    ResourceCategoryData(
      icon: Icons.cases_outlined,
      title: '案例分析',
      description: '深度剖析商业、科技等领域经典案例，培养逻辑思维。',
      tags: <String>['商业分析', '创新案例'],
      tint: AppColors.tertiary,
    ),
    ResourceCategoryData(
      icon: Icons.psychology_outlined,
      title: 'AI 辅导',
      description: '基于大模型的智能辅导系统，随时解答疑惑，定制学习路径。',
      tags: <String>['智能答疑', '路径规划'],
      tint: AppColors.secondary,
    ),
  ];

  static const String pathBadge = 'SUCCESS PATH';
  static const String pathTitle = '赛·创·就 全链路孵化';
  static const String pathDescription = '打造从学科竞赛到创新实践，最终走向名企就业的完整闭环成长路径';
  static const String pathActionLabel = '开启我的成长路径';
  static const String pathCompactTitleSeparator = ' · ';
  static const List<ResourcePathStepData> pathSteps = <ResourcePathStepData>[
    ResourcePathStepData(
      icon: Icons.emoji_events_outlined,
      title: '赛 (Compete)',
      badge: '能力认证',
      description: '通过高水平竞赛磨炼专业技能，获取权威能力背书',
      tint: AppColors.primary,
      orderLabel: '01',
    ),
    ResourcePathStepData(
      icon: Icons.lightbulb_outline_rounded,
      title: '创 (Create)',
      badge: '项目实践',
      description: '将竞赛成果转化为真实项目，提升解决复杂问题的能力',
      tint: AppColors.tertiary,
      orderLabel: '02',
    ),
    ResourcePathStepData(
      icon: Icons.work_outline_rounded,
      title: '就 (Career)',
      badge: '名企直通',
      description: '对接优质企业资源，实现从校园到职场的无缝飞跃',
      tint: AppColors.secondary,
      orderLabel: '03',
    ),
  ];

  static const String showcaseSectionTitle = '院校成果展示';
  static const String showcaseActionLabel = '查看全部';
  static const String categoryEmptyTitle = '暂无匹配资源分类';
  static const String categoryEmptyDescription = '换个关键词继续探索吧。';
  static const String showcaseEmptyTitle = '暂无匹配院校成果';
  static const String showcaseEmptyDescription = '请尝试其他关键词。';
  static const List<ResourceAchievementData>
  showcases = <ResourceAchievementData>[
    ResourceAchievementData(
      label: '金奖案例',
      title: '清华大学 - 智能制造创新实践',
      description: '第十五届全国大学生智能车竞赛特等奖团队纪实与技术方案分享。',
      views: '1.2k',
      likes: '342',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDIhTjYz9rZ1FkKOR8xzdVTUGF4X6btLO4GiFCUiqsq4Gy6_jWuicoV_Nn-0EArni6ZjKsYfMDRkPELDiHTE7gE4cItG33SvhPdPdSaUcDgTZ5NPcC44kktIS0JqLBhJFI50-klc-2PY9yGwvLZWrSJ4vPLR3WUvm0IdgV7hi35NCdMSVA0O76k9r9Hsr_Gbic_fOnNwS6rBvLTdoGVFoTVnP8zfgmpAkdnl2C7KYZcnypN-qXLTWywhI64YnqS6I4ivnbAUblVApZy',
      labelTint: AppColors.primary,
    ),
    ResourceAchievementData(
      label: '优秀孵化',
      title: '上海交大 - 零碳校园商业计划',
      description: '从创意构想到落地融资，商赛一等奖团队的完整路演材料与复盘。',
      views: '890',
      likes: '215',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDkQxQD3eyzuFK6Ur0TEh64PjUtF514HpAYywOKUgzntx5uIoP86g01AvfbPR_5VWG1p2ba_tFfQo3dRI0FIuB7BuH8SrHwXnu5a8gdjzyXA1CF2B8T4IA2RNbVxeW7daS1fWGeMSkdxYzIo4jkMeh7P2voQuiSeJ_lSRlQgDXoQZ5te8wpa7wOHhSd0REjsyzZn1HuROvM8puJXr1bALaX0KWPiBJks7lSywVN_0n7QT9i_L-6pjTTurxY9KUUcl5LQK7C3UE0RvRC',
      labelTint: AppColors.tertiary,
    ),
    ResourceAchievementData(
      label: '前沿探索',
      title: '浙江大学 - 医疗大模型应用研究',
      description: '结合医疗垂直领域数据，探索大模型在辅助诊断中的应用潜力。',
      views: '2.1k',
      likes: '560',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDJtAQYzrpG0JxbAPZq7F1kd4wrL4XjO93QXoUSiS0YRVd5A8oxBz_QfhbeK3pHQXV1CVTOI5yeYJ9ISQsiupiVtGwJUh_WqX7nW04vUWPZ6AlWUy-fGaU7WeMRwT1FAPeqlIRAd5cSmCmbSZj0gfXn_jPM-IF_itaQthToDkVk0C5GyiZQqqSKlphKvl48nZC2C04UnThz3QZOS2xIDKAZZK2pzx_tv5FbsDUZrMn1tVz7I-JXnPa5rMC_VF2oCkC5_HsXxwT61l9-',
      labelTint: AppColors.secondary,
    ),
  ];
}
