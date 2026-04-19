import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock/home_mock_data.dart';

final homeViewDataProvider = Provider<HomeViewData>(
  (ref) => const HomeViewData(),
);

class HomeViewData {
  const HomeViewData();

  HomeHeroContent get hero => HomeMockData.hero;
  HomeCountdownContent get countdown => HomeMockData.countdown;
  List<HomeQuickActionData> get quickActions => HomeMockData.quickActions;
  List<HomeLiveUpdateData> get liveUpdates => HomeMockData.liveUpdates;
  HomeBenchmarkCaseContent get benchmarkCase => HomeMockData.benchmarkCase;

  double get primarySplitMinWidth => HomeMockData.primarySplitMinWidth;
  double get secondarySplitMinWidth => HomeMockData.secondarySplitMinWidth;
  double get heroCompactMaxWidth => HomeMockData.heroCompactMaxWidth;
  double get heroTitleScaleFactor => HomeMockData.heroTitleScaleFactor;
  double get heroTitleMinSize => HomeMockData.heroTitleMinSize;
  double get heroTitleMaxSize => HomeMockData.heroTitleMaxSize;
  double get heroSubtitleScaleFactor => HomeMockData.heroSubtitleScaleFactor;
  double get heroSubtitleMinSize => HomeMockData.heroSubtitleMinSize;
  double get heroSubtitleMaxSize => HomeMockData.heroSubtitleMaxSize;
  double get quickActionCompactMaxWidth => HomeMockData.quickActionCompactMaxWidth;
  double get quickActionAspectRatio => HomeMockData.quickActionAspectRatio;

  String get quickActionTitle => HomeMockData.quickActionTitle;
  String get liveUpdateTitle => HomeMockData.liveUpdateTitle;
  String get liveUpdateActionLabel => HomeMockData.liveUpdateActionLabel;
  String get benchmarkTitle => HomeMockData.benchmarkTitle;
}
