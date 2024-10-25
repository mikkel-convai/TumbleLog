// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillModel _$SkillModelFromJson(Map<String, dynamic> json) => SkillModel(
      id: json['id'] as String?,
      sessionId: json['sessionId'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      difficulty: (json['difficulty'] as num).toDouble(),
      equipmentReps: (json['equipmentReps'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            $enumDecode(_$EquipmentTypeEnumMap, k), (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$SkillModelToJson(SkillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'name': instance.name,
      'symbol': instance.symbol,
      'difficulty': instance.difficulty,
      'equipmentReps': instance.equipmentReps
          .map((k, e) => MapEntry(_$EquipmentTypeEnumMap[k]!, e)),
    };

const _$EquipmentTypeEnumMap = {
  EquipmentType.rodFloor: 'rodFloor',
  EquipmentType.airFloor: 'airFloor',
  EquipmentType.airRodFloor: 'airRodFloor',
  EquipmentType.dmt: 'dmt',
  EquipmentType.trampoline: 'trampoline',
};
