import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/competition.dart';

part 'competition_model.g.dart';

@JsonSerializable()
class CompetitionModel extends Competition {
  const CompetitionModel({
    required super.id,
    required super.title,
    required super.status,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) =>
      _$CompetitionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompetitionModelToJson(this);
}
