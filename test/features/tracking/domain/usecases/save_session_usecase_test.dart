import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/core/utils/success.dart';
import 'package:tumblelog/features/tracking/domain/usecases/save_session_usecase.dart';
import 'package:tumblelog/core/utils/failure.dart';

import '../repositories/session_repository.mocks.dart';

void main() {
  late SaveSessionUseCase saveSessionUseCase;
  late MockSessionRepository mockSessionRepository;

  setUp(() {
    mockSessionRepository = MockSessionRepository();
    saveSessionUseCase = SaveSessionUseCase(repository: mockSessionRepository);
  });

  test('Save session using use case', () async {
    // Arrange
    final SessionEntity session = SessionEntity(
      id: 'id',
      athleteId: 'athleteId',
      date: DateTime.now(),
    );

    final List<SkillEntity> skills = [
      SkillEntity(
        sessionId: 'sessionId',
        name: 'whip',
        symbol: '^',
        difficulty: 0.2,
      ),
      SkillEntity(
        sessionId: 'sessionId',
        name: 'db strakt',
        symbol: '--/',
        difficulty: 2.4,
      ),
    ];

    // Stub the method to return a successful response
    when(mockSessionRepository.saveSession(session, skills)).thenAnswer(
        (_) async => Right(Success(message: 'Session saved successfully')));

    // Act
    await saveSessionUseCase.execute(session: session, skills: skills);

    // Assert
    verify(mockSessionRepository.saveSession(session, skills)).called(1);
  });

  test('Save session should return a failure', () async {
    // Arrange
    final SessionEntity session = SessionEntity(
      id: 'id',
      athleteId: 'athleteId',
      date: DateTime.now(),
    );

    final List<SkillEntity> skills = [
      SkillEntity(
        sessionId: 'sessionId',
        name: 'whip',
        symbol: '^',
        difficulty: 0.2,
      ),
      SkillEntity(
        sessionId: 'sessionId',
        name: 'db strakt',
        symbol: '--/',
        difficulty: 2.4,
      ),
    ];

    // Stub the method to return a failure response
    when(mockSessionRepository.saveSession(session, skills)).thenAnswer(
        (_) async => Left(Failure(message: 'Failed to save session')));

    // Act
    final result =
        await saveSessionUseCase.execute(session: session, skills: skills);

    // Assert
    verify(mockSessionRepository.saveSession(session, skills)).called(1);
    expect(result.isLeft(), true);
  });
}
