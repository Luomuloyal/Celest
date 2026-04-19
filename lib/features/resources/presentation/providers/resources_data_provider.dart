import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock/resources_mock_data.dart';

final resourcesViewDataProvider = Provider<ResourcesViewData>(
  (ref) => const ResourcesViewData(),
);

class ResourcesViewData {
  const ResourcesViewData();

  List<ResourceCategoryData> get categories => ResourcesMockData.categories;
  List<ResourcePathStepData> get pathSteps => ResourcesMockData.pathSteps;
  List<ResourceAchievementData> get showcases => ResourcesMockData.showcases;

  String get appTitle => ResourcesMockData.appTitle;
  String get avatarUrl => ResourcesMockData.avatarUrl;
  String get heroTitle => ResourcesMockData.heroTitle;
  String get heroSubtitle => ResourcesMockData.heroSubtitle;
  String get searchHint => ResourcesMockData.searchHint;
  String get searchButtonLabel => ResourcesMockData.searchButtonLabel;
  String get categorySectionTitle => ResourcesMockData.categorySectionTitle;
  String get pathBadge => ResourcesMockData.pathBadge;
  String get pathTitle => ResourcesMockData.pathTitle;
  String get pathDescription => ResourcesMockData.pathDescription;
  String get pathActionLabel => ResourcesMockData.pathActionLabel;
  String get pathCompactTitleSeparator =>
      ResourcesMockData.pathCompactTitleSeparator;
  String get showcaseSectionTitle => ResourcesMockData.showcaseSectionTitle;
  String get showcaseActionLabel => ResourcesMockData.showcaseActionLabel;
  String get categoryEmptyTitle => ResourcesMockData.categoryEmptyTitle;
  String get categoryEmptyDescription => ResourcesMockData.categoryEmptyDescription;
  String get showcaseEmptyTitle => ResourcesMockData.showcaseEmptyTitle;
  String get showcaseEmptyDescription => ResourcesMockData.showcaseEmptyDescription;

  double get categoryThreeColumnMinWidth =>
      ResourcesMockData.categoryThreeColumnMinWidth;
  double get categoryTwoColumnMinWidth =>
      ResourcesMockData.categoryTwoColumnMinWidth;
  double get showcaseThreeColumnMinWidth =>
      ResourcesMockData.showcaseThreeColumnMinWidth;
  double get showcaseTwoColumnMinWidth =>
      ResourcesMockData.showcaseTwoColumnMinWidth;
  double get compactPathMaxWidth => ResourcesMockData.compactPathMaxWidth;
  double get categoryGridItemExtent => ResourcesMockData.categoryGridItemExtent;
  double get showcaseGridItemExtent => ResourcesMockData.showcaseGridItemExtent;
}
