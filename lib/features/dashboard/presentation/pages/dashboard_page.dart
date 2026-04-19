import 'package:flutter/material.dart';

import '../../../../core/common/widgets/app_placeholder_page.dart';
import '../../../../l10n/l10n.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPlaceholderPage(title: context.l10n.navWorkspace);
  }
}
