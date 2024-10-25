import 'package:tumblelog/core/models/session_model.dart';

abstract class SessionRemoteDataSource {
  Future<void> saveSession(SessionModel session);
}

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  @override
  Future<void> saveSession(SessionModel session) async {
    print('Saving model to db: $session');
  }
}
