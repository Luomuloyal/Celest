import 'package:flutter/material.dart';

import '../../../../core/common/responsive_layout.dart';
import '../widgets/competition_desktop_view.dart';
import '../widgets/competition_mobile_view.dart';
import '../widgets/competition_tablet_view.dart';

class CompetitionPage extends StatelessWidget {
  const CompetitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: CompetitionMobileView(),
      tablet: CompetitionTabletView(),
      desktop: CompetitionDesktopView(),
    );
  }
}
