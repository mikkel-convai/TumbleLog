import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/features/tracking/domain/repositories/session_repository.dart';

class LoadSkillsUseCase {
  final SessionRepository repository;

  LoadSkillsUseCase({required this.repository});

  // Future<List<SkillEntity>> execute() async {
  Future<List<SkillEntity>> execute(String sessionId) async {
    print('load skills use case');
    return [];
  }
}
