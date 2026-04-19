import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/responsive_layout.dart';
import '../providers/competition_providers.dart';
import '../widgets/competition_state_view.dart';

class CompetitionPage extends ConsumerWidget {
  const CompetitionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final competitions = ref.watch(competitionListProvider);
    final wideView = CompetitionStateView(
      viewportLabel: 'Competition wide',
      competitions: competitions,
    );

    return ResponsiveLayout(
      mobile: CompetitionStateView(
        viewportLabel: 'Competition mobile',
        competitions: competitions,
      ),
      tablet: wideView,
      desktop: wideView,
    );
  }
}
