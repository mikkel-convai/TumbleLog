import 'package:tumblelog/core/entities/skill_entity.dart';

abstract class SkillRepository {
  Future<List<SkillEntity>> loadSkills(String sessionId);
}
