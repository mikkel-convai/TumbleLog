import 'package:tumblelog/core/entities/session_entity.dart';

abstract class SessionRepository {
  Future<void> saveSession(SessionEntity session);
}
