import 'dart:convert';
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
