import 'package:flutter/material.dart';

import '../../../../core/common/widgets/app_placeholder_page.dart';
import '../../../../l10n/l10n.dart';

class CompetitionPage extends StatelessWidget {
  const CompetitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPlaceholderPage(title: context.l10n.navCompetition);
  }
}
