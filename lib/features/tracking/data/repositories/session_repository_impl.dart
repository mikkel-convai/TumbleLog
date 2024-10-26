import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/core/models/session_model.dart';
import 'package:tumblelog/core/models/skill_model.dart';
import 'package:tumblelog/features/tracking/data/datasources/session_remote_datasource.dart';
import 'package:tumblelog/features/tracking/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteDataSource remoteDataSource;

  SessionRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<void> saveSession(
    SessionEntity session,
    List<SkillEntity> skills,
  ) async {
    final sessionModel = SessionModel(
      id: session.id,
      athleteId: session.athleteId,
      date: session.date,
      athleteName: session.athleteName,
    );

    final List<SkillModel> skillModels = skills.map((skill) {
      return SkillModel(
        id: skill.id,
        sessionId: skill.sessionId,
        name: skill.name,
        symbol: skill.symbol,
        difficulty: skill.difficulty,
        equipmentReps: skill.equipmentReps,
      );
    }).toList();

    await remoteDataSource.saveSession(sessionModel, skillModels);
  }
}
