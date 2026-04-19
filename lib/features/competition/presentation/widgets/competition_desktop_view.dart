import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/competition.dart';
import 'competition_state_view.dart';

class CompetitionDesktopView extends StatelessWidget {
  const CompetitionDesktopView({super.key, required this.competitions});

  final AsyncValue<List<Competition>> competitions;

  @override
  Widget build(BuildContext context) {
    return CompetitionStateView(
      viewportLabel: 'Competition desktop',
      competitions: competitions,
    );
  }
}
