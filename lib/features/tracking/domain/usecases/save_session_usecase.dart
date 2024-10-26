import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/features/tracking/domain/repositories/session_repository.dart';

class SaveSessionUseCase {
  final SessionRepository repository;

  SaveSessionUseCase({required this.repository});

  Future<void> execute(
      {required SessionEntity session, required List<SkillEntity> skills}) {
    return repository.saveSession(session, skills);
  }
}
