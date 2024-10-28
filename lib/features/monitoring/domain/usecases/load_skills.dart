import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/features/monitoring/domain/repositories/skill_repository.dart';

class LoadSkillsUseCase {
  final SkillRepository repository;

  LoadSkillsUseCase({required this.repository});

  Future<List<SkillEntity>> execute(String sessionId) async {
    return await repository.loadSkills(sessionId);
  }
}
