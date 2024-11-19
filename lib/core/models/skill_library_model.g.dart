// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_library_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillLibraryModel _$SkillLibraryModelFromJson(Map<String, dynamic> json) =>
    SkillLibraryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      difficulty: (json['difficulty'] as num).toDouble(),
      creatorId: json['creator_id'] as String?,
      isDefault: json['is_default'] as bool,
    );

Map<String, dynamic> _$SkillLibraryModelToJson(SkillLibraryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'difficulty': instance.difficulty,
      'creator_id': instance.creatorId,
      'is_default': instance.isDefault,
    };
