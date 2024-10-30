// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      id: json['id'] as String,
      athleteId: json['athlete_id'] as String,
      date: DateTime.parse(json['date'] as String),
      totalDd: (json['total_dd'] as num?)?.toDouble() ?? 0,
      athleteName: json['athlete_name'] as String? ?? 'Grisha',
      equipmentDd: (json['equipment_dd'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                $enumDecode(_$EquipmentTypeEnumMap, k), (e as num).toDouble()),
          ) ??
          defaultEquipmentDd,
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'athlete_id': instance.athleteId,
      'athlete_name': instance.athleteName,
      'date': instance.date.toIso8601String(),
      'total_dd': instance.totalDd,
      'equipment_dd': instance.equipmentDd
          .map((k, e) => MapEntry(_$EquipmentTypeEnumMap[k]!, e)),
    };

const _$EquipmentTypeEnumMap = {
  EquipmentType.rodFloor: 'rodFloor',
  EquipmentType.airFloor: 'airFloor',
  EquipmentType.airRodFloor: 'airRodFloor',
  EquipmentType.dmt: 'dmt',
  EquipmentType.trampoline: 'trampoline',
};
