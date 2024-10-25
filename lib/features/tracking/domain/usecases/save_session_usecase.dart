import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/features/tracking/domain/repositories/session_repository.dart';

class SaveSessionUseCase {
  final SessionRepository repository;

  SaveSessionUseCase({required this.repository});

  Future<void> execute({required SessionEntity session}) {
    return repository.saveSession(session);
  }
}
