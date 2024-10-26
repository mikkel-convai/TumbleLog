import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/models/session_model.dart';
import 'package:tumblelog/core/models/skill_model.dart';

abstract class SessionRemoteDataSource {
  Future<void> saveSession(SessionModel session, List<SkillModel> skills);
}

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  final SupabaseClient _supabaseClient;

  SessionRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<void> saveSession(
      SessionModel session, List<SkillModel> skills) async {
    // Convert session and skills to JSON
    final Map<String, dynamic> sessionJson = session.toJson();
    final List<Map<String, dynamic>> skillsJson =
        skills.map((skill) => skill.toJson()).toList();

    try {
      // Insert session into the 'sessions' table
      final List<Map<String, dynamic>> sessionRes =
          await _supabaseClient.from('sessions').insert(sessionJson).select();

      // Insert skills into the 'skills' table
      final List<Map<String, dynamic>> skillRes =
          await _supabaseClient.from('skills').insert(skillsJson).select();

      print('Session and skills saved successfully.');
    } catch (e) {
      print('Error saving session and skills: $e');
      rethrow;
    }
  }
}
