import 'package:tumblelog/core/models/session_model.dart';
import 'package:tumblelog/core/models/skill_model.dart';

abstract class SessionRemoteDataSource {
  Future<void> saveSession(SessionModel session, List<SkillModel> skills);
}

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  @override
  Future<void> saveSession(
      SessionModel session, List<SkillModel> skills) async {
    print('Saving model to db: $session');
  }
}
