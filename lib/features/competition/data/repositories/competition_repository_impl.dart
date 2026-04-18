import '../../domain/entities/competition.dart';
import '../../domain/repositories/competition_repository.dart';

class CompetitionRepositoryImpl implements CompetitionRepository {
  @override
  Future<List<Competition>> getCompetitions() async {
    return const [
      Competition(
        id: 'comp-001',
        title: 'Celest Demo Competition',
        status: 'draft',
      ),
    ];
  }
}
