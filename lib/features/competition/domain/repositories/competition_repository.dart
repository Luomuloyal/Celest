import '../entities/competition.dart';

abstract class CompetitionRepository {
  Future<List<Competition>> getCompetitions();
}
