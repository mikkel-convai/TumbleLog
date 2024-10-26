import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/core/models/session_model.dart';
import 'package:tumblelog/core/models/skill_model.dart';
import 'package:tumblelog/features/tracking/data/repositories/session_repository_impl.dart';

import '../datasources/remote_datasource.mocks.dart';

void main() {
  late MockSessionRemoteDataSourceImpl mockRemoteDataSource;
  late SessionRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockSessionRemoteDataSourceImpl();
    repository = SessionRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  test('should call remoteDataSource.saveSession with correct models',
      () async {
    // Arrange
    final session = SessionEntity(
      id: 'session1',
      athleteId: 'athlete1',
      date: DateTime.now(),
      athleteName: 'John Doe',
    );

    final skills = [
      SkillEntity(
        sessionId: 'session1',
        name: 'Skill 1',
        symbol: 'S1',
        difficulty: 1.0,
      ),
      SkillEntity(
        sessionId: 'session1',
        name: 'Skill 2',
        symbol: 'S2',
        difficulty: 2.0,
      ),
    ];

    final sessionModel = SessionModel(
      id: session.id,
      athleteId: session.athleteId,
      date: session.date,
      athleteName: session.athleteName,
    );

    final skillModels = skills.map((skill) {
      return SkillModel(
        id: skill.id,
        sessionId: skill.sessionId,
        name: skill.name,
        symbol: skill.symbol,
        difficulty: skill.difficulty,
        equipmentReps: skill.equipmentReps,
      );
    }).toList();

    // Act
    await repository.saveSession(session, skills);

    // Assert
    verify(mockRemoteDataSource.saveSession(sessionModel, skillModels))
        .called(1);
  });
}
