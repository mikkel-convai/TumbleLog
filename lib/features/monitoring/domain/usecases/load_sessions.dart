import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/features/tracking/domain/repositories/session_repository.dart';

class LoadSessionsUseCase {
  final SessionRepository repository;

  LoadSessionsUseCase({required this.repository});

  Future<List<SessionEntity>> execute({String? athleteId}) async {
    return await repository.loadSessions(athleteId: athleteId);
  }
}
