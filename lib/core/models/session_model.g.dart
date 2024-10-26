// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      id: json['id'] as String,
      athleteId: json['athlete_id'] as String,
      date: DateTime.parse(json['date'] as String),
      athleteName: json['athlete_name'] as String? ?? 'Grisha',
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'athlete_id': instance.athleteId,
      'athlete_name': instance.athleteName,
      'date': instance.date.toIso8601String(),
    };
