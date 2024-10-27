import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/utils/json_to_session_model.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_sessions.dart';

import '../../../tracking/domain/repositories/session_repository.mocks.dart';

void main() {
  late LoadSessionsUseCase loadSessions;
  late MockSessionRepository mockSessionRepository;

  final List<SessionEntity> mockSessions =
      parseSessionEntitiesFromString(defaultSessionJson);

  setUp(() {
    mockSessionRepository = MockSessionRepository();
    loadSessions = LoadSessionsUseCase(repository: mockSessionRepository);
  });

  test('Should call repo.loadSessions and return list of sessions', () async {
    // Arrange
    when(mockSessionRepository.loadSessions())
        .thenAnswer((_) async => mockSessions);
    // Act
    final List<SessionEntity> sessions = await loadSessions.execute();

    // Should make repo call
    verify(mockSessionRepository.loadSessions()).called(1);
    // Should return list of sessions
    expect(sessions, isA<List<SessionEntity>>());
  });
}
