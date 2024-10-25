import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/models/session_model.dart';
import 'package:tumblelog/features/tracking/data/datasources/session_remote_datasource.dart';
import 'package:tumblelog/features/tracking/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteDataSourceImpl remoteDataSource;

  SessionRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<void> saveSession(SessionEntity session) async {
    final sessionModel = SessionModel(
      id: session.id,
      athleteId: session.athleteId,
      date: session.date,
      athleteName: session.athleteName,
    );

    await remoteDataSource.saveSession(sessionModel);
  }
}
