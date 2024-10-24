import 'dart:convert';
import 'package:tumblelog/features/tracking/domain/entities/skill_entity.dart';

List<SkillEntity> mapJsonToSkillEntities(String jsonString) {
  final List<dynamic> skillJsonList = jsonDecode(jsonString);

  return skillJsonList.map((jsonSkill) {
    return SkillEntity(
      name: jsonSkill['name'],
      symbol: jsonSkill['symbol'],
      difficulty: jsonSkill['difficulty'],
    );
  }).toList();
}
