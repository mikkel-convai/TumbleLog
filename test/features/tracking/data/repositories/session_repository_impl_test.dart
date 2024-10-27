import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/core/models/session_model.dart';
import 'package:tumblelog/core/models/skill_model.dart';
import 'package:tumblelog/core/utils/json_to_session_model.dart';
import 'package:tumblelog/features/tracking/data/repositories/session_repository_impl.dart';
import 'package:tumblelog/core/utils/success.dart';

import '../datasources/remote_datasource.mocks.dart';

void main() {
  late MockSessionRemoteDataSourceImpl mockRemoteDataSource;
  late SessionRepositoryImpl repository;

  final List<SessionModel> mockSessionModels =
      parseSessionsFromString(defaultSessionJson);

  setUp(() {
    mockRemoteDataSource = MockSessionRemoteDataSourceImpl();
    repository = SessionRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  test(
      'loadSession should call remote data source to get sessions and transform from model to entity',
      () async {
    // Arrange
    when(mockRemoteDataSource.loadSessions())
        .thenAnswer((_) async => mockSessionModels);

    // Act
    final List<SessionEntity> sessions = await repository.loadSessions();

    // Assert
    verify(mockRemoteDataSource.loadSessions()).called(1);
    expect(sessions, isA<List<SessionEntity>>());
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

    // Stub the saveSession method to return a success response
    when(mockRemoteDataSource.saveSession(any, any))
        .thenAnswer((_) async => Right(Success(message: 'Session uploaded.')));

    // Act
    await repository.saveSession(session, skills);

    // Assert
    verify(mockRemoteDataSource.saveSession(sessionModel, skillModels))
        .called(1);
  });
}
