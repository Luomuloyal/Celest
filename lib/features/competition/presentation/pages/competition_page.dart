import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/responsive_layout.dart';
import '../providers/competition_providers.dart';
import '../widgets/competition_desktop_view.dart';
import '../widgets/competition_mobile_view.dart';
import '../widgets/competition_tablet_view.dart';

class CompetitionPage extends ConsumerWidget {
  const CompetitionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final competitions = ref.watch(competitionListProvider);

    return ResponsiveLayout(
      mobile: CompetitionMobileView(competitions: competitions),
      tablet: CompetitionTabletView(competitions: competitions),
      desktop: CompetitionDesktopView(competitions: competitions),
    );
  }
}
