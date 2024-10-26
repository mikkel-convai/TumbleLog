import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/features/tracking/domain/usecases/save_session_usecase.dart';

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
      )
    ];

    // Act
    await saveSessionUseCase.execute(session: session, skills: skills);

    // Assert
    verify(mockSessionRepository.saveSession(session, skills)).called(1);
  });
}
