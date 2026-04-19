import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/competition.dart';
import 'competition_state_view.dart';

class CompetitionTabletView extends StatelessWidget {
  const CompetitionTabletView({super.key, required this.competitions});

  final AsyncValue<List<Competition>> competitions;

  @override
  Widget build(BuildContext context) {
    return CompetitionStateView(
      viewportLabel: 'Competition tablet',
      competitions: competitions,
    );
  }
}
