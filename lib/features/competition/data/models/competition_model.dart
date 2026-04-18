import '../../domain/entities/competition.dart';

class CompetitionModel extends Competition {
  const CompetitionModel({
    required super.id,
    required super.title,
    required super.status,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    return CompetitionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
    };
  }
}
