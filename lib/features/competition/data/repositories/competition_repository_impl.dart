import '../models/competition_model.dart';
import '../../domain/entities/competition.dart';
import '../../domain/repositories/competition_repository.dart';

class CompetitionRepositoryImpl implements CompetitionRepository {
  @override
  Future<List<Competition>> getCompetitions() async {
    const rawCompetitions = [
      {
        'id': 'comp-001',
        'title': 'Celest Demo Competition',
        'status': 'draft',
      },
    ];

    return rawCompetitions.map(CompetitionModel.fromJson).toList();
  }
}
