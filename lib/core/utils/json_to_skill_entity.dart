import 'dart:convert';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';

List<SkillEntity> mapJsonToSkillEntities(String jsonString, String sessionId) {
  final List<dynamic> skillJsonList = jsonDecode(jsonString);

  return skillJsonList.map((jsonSkill) {
    return SkillEntity(
      sessionId: sessionId,
      name: jsonSkill['name'],
      symbol: jsonSkill['symbol'],
      difficulty: jsonSkill['difficulty'],
    );
  }).toList();
}

List<SkillEntity> parseSkillsFromJson(String jsonString, String sessionId) {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList
      .where((json) => json['session_id'] == sessionId)
      .map<SkillEntity>((json) => SkillEntity(
            id: json['id'],
            sessionId: json['session_id'],
            name: json['name'],
            symbol: json['symbol'],
            difficulty: json['difficulty'].toDouble(),
            equipmentReps: (json['equipment_reps'] as Map<String, dynamic>).map(
              (key, value) =>
                  MapEntry(equipmentTypeFromString(key), value as int),
            ),
          ))
      .toList();
}

EquipmentType equipmentTypeFromString(String equipment) {
  switch (equipment) {
    case 'rodFloor':
      return EquipmentType.rodFloor;
    case 'airRodFloor':
      return EquipmentType.airRodFloor;
    case 'airFloor':
      return EquipmentType.airFloor;
    case 'dmt':
      return EquipmentType.dmt;
    case 'trampoline':
      return EquipmentType.trampoline;
    default:
      throw ArgumentError('Unknown equipment type: $equipment');
  }
}
