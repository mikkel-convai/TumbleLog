import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/features/tracking/domain/repositories/session_repository.dart';
import 'package:tumblelog/core/utils/failure.dart';
import 'package:tumblelog/core/utils/success.dart';
import 'package:dartz/dartz.dart';

class SaveSessionUseCase {
  final SessionRepository repository;

  SaveSessionUseCase({required this.repository});

  Future<Either<Failure, Success>> execute(
      {required SessionEntity session, required List<SkillEntity> skills}) {
    return repository.saveSession(session, skills);
  }
}
