import '../entities/competition.dart';
import '../repositories/competition_repository.dart';

class GetCompetitionList {
  const GetCompetitionList(this.repository);

  final CompetitionRepository repository;

  Future<List<Competition>> call() {
    return repository.getCompetitions();
  }
}
