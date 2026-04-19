// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompetitionModel _$CompetitionModelFromJson(Map<String, dynamic> json) =>
    CompetitionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$CompetitionModelToJson(CompetitionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
    };
