import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
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

    // Act
    await saveSessionUseCase.execute(session: session);

    // Assert
    verify(mockSessionRepository.saveSession(session)).called(1);
  });
}
