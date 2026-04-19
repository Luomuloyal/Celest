import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/competition.dart';
import '../providers/competition_providers.dart';

class CompetitionStateView extends ConsumerWidget {
  const CompetitionStateView({
    super.key,
    required this.viewportLabel,
    required this.competitions,
  });

  final String viewportLabel;
  final AsyncValue<List<Competition>> competitions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: competitions.when(
          data: (items) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$viewportLabel view'),
              const SizedBox(height: 8),
              Text('Loaded ${items.length} competitions'),
              if (items.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(items.first.title),
              ],
            ],
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text('Error: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.invalidate(competitionListProvider),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
