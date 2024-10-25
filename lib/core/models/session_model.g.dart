// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      id: json['id'] as String,
      athleteId: json['athleteId'] as String,
      date: DateTime.parse(json['date'] as String),
      athleteName: json['athleteName'] as String? ?? 'Grisha',
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'athleteId': instance.athleteId,
      'athleteName': instance.athleteName,
      'date': instance.date.toIso8601String(),
    };
