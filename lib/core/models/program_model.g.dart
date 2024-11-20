// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramModel _$ProgramModelFromJson(Map<String, dynamic> json) => ProgramModel(
      id: json['id'] as String,
      name: json['name'] as String,
      creatorId: json['creator_id'] as String?,
      skills: ProgramModel._extractSkillsFromProgramSkills(
          json['program_skills'] as List?),
    );

Map<String, dynamic> _$ProgramModelToJson(ProgramModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creator_id': instance.creatorId,
      'program_skills': instance.skills.map((e) => e.toJson()).toList(),
    };
