// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramModel _$ProgramModelFromJson(Map<String, dynamic> json) => ProgramModel(
      id: json['id'] as String,
      name: json['name'] as String,
      creatorId: json['creator_id'] as String?,
      skills: (json['skills'] as List<dynamic>)
          .map((e) => SkillLibraryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProgramModelToJson(ProgramModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creator_id': instance.creatorId,
      'skills': instance.skills.map((e) => e.toJson()).toList(),
    };
