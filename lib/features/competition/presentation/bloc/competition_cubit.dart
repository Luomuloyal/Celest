import 'package:flutter/foundation.dart';

import '../../domain/entities/competition.dart';
import '../../domain/usecases/get_competition_list.dart';

class CompetitionCubit extends ChangeNotifier {
  CompetitionCubit(this._getCompetitionList);

  final GetCompetitionList _getCompetitionList;

  List<Competition> competitions = const [];

  Future<void> load() async {
    competitions = await _getCompetitionList();
    notifyListeners();
  }
}
