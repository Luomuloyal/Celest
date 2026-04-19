import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/competition_repository_impl.dart';
import '../../domain/entities/competition.dart';
import '../../domain/repositories/competition_repository.dart';

final competitionRepositoryProvider = Provider<CompetitionRepository>(
  (ref) => CompetitionRepositoryImpl(),
);

final competitionListProvider = FutureProvider<List<Competition>>((ref) {
  return ref.watch(competitionRepositoryProvider).getCompetitions();
});
