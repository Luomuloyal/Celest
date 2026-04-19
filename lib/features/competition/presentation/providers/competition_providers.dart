import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/competition.dart';
import '../../domain/usecases/get_competition_list.dart';

final getCompetitionListProvider = Provider<GetCompetitionList>(
  (ref) => sl<GetCompetitionList>(),
);

final competitionListProvider =
    AsyncNotifierProvider<CompetitionListController, List<Competition>>(
      CompetitionListController.new,
    );

class CompetitionListController extends AsyncNotifier<List<Competition>> {
  @override
  Future<List<Competition>> build() {
    return ref.read(getCompetitionListProvider).call();
  }

  Future<void> reload() async {
    state = const AsyncLoading<List<Competition>>();
    state = await AsyncValue.guard(
      () => ref.read(getCompetitionListProvider).call(),
    );
  }
}
