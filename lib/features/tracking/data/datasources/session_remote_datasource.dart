import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/models/session_model.dart';
import 'package:tumblelog/core/models/skill_model.dart';
import 'package:tumblelog/core/utils/failure.dart';
import 'package:tumblelog/core/utils/json_to_session_model.dart';
import 'package:tumblelog/core/utils/success.dart';

abstract class SessionRemoteDataSource {
  Future<Either<Failure, Success>> saveSession(
      SessionModel session, List<SkillModel> skills);

  Future<List<SessionModel>> loadSessions();
}

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  final SupabaseClient _supabaseClient;

  SessionRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<Either<Failure, Success>> saveSession(
      SessionModel session, List<SkillModel> skills) async {
    // Convert session and skills to JSON
    final Map<String, dynamic> sessionJson = session.toJson();
    final List<Map<String, dynamic>> skillsJson =
        skills.map((skill) => skill.toJson()).toList();

    try {
      // Insert session into the 'sessions' table
      final List<Map<String, dynamic>> sessionRes =
          await _supabaseClient.from('sessions').insert(sessionJson).select();

      if (sessionRes.isEmpty) {
        return Left(Failure(message: 'No sessions where uploaded'));
      }

      // Insert skills into the 'skills' table
      final List<Map<String, dynamic>> skillRes =
          await _supabaseClient.from('skills').insert(skillsJson).select();

      if (skillRes.isEmpty) {
        return Left(Failure(message: 'No skills where uploaded'));
      }

      return Right(Success(message: 'Session uploaded.'));
    } catch (e) {
      return Left(Failure(message: 'Error saving session and skills: $e'));
    }
  }

  @override
  Future<List<SessionModel>> loadSessions() async {
    // Call supabase

    // Transform JSON -> Model

    // Return models

    // TODO: implement loadSessions
    return parseSessionModelsFromString(defaultSessionJson);
  }
}
