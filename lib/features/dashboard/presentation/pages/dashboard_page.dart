import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/home_sections.dart';

@Deprecated('Use HomePage from features/home instead.')
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeSections();
  }
}
