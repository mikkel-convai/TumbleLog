import 'package:dartz/dartz.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/core/utils/failure.dart';
import 'package:tumblelog/core/utils/success.dart';

abstract class SessionRepository {
  Future<Either<Failure, Success>> saveSession(
      SessionEntity session, List<SkillEntity> skills);

  Future<List<SessionEntity>> loadSessions({String? athleteId});
}
