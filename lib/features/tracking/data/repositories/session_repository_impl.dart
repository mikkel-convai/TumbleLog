import 'package:dartz/dartz.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/core/models/session_model.dart';
import 'package:tumblelog/core/models/skill_model.dart';
import 'package:tumblelog/core/utils/failure.dart';
import 'package:tumblelog/core/utils/success.dart';
import 'package:tumblelog/features/tracking/data/datasources/session_remote_datasource.dart';
import 'package:tumblelog/features/tracking/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteDataSource remoteDataSource;

  SessionRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Success>> saveSession(
    SessionEntity session,
    List<SkillEntity> skills,
  ) async {
    final sessionModel = SessionModel(
      id: session.id,
      athleteId: session.athleteId,
      date: session.date,
      athleteName: session.athleteName,
      totalDd: session.totalDd,
      equipmentDd: session.equipmentDd,
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

    return await remoteDataSource.saveSession(sessionModel, skillModels);
  }

  @override
  Future<List<SessionEntity>> loadSessions({String? athleteId}) async {
    try {
      // Call remote data source
      final List<SessionModel> sessionModels =
          await remoteDataSource.loadSessions(athleteId: athleteId);

      // Transform model to entity
      final List<SessionEntity> sessions = sessionModels.map((session) {
        return SessionEntity(
          id: session.id,
          athleteId: session.athleteId,
          athleteName: session.athleteName,
          totalDd: session.totalDd,
          equipmentDd: session.equipmentDd,
          date: session.date,
        );
      }).toList();

      // return session entity
      return sessions;
    } catch (e) {
      // TODO: Handle errors
      print('Error occured: $e');
      return [];
    }
  }
}
