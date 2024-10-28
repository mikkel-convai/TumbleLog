import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/models/skill_model.dart';

abstract class SkillRemoteDataSource {
  Future<List<SkillModel>> loadSkills(String sessionId);
}

class SkillRemoteDataSourceImpl implements SkillRemoteDataSource {
  final SupabaseClient supabaseClient;

  SkillRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<SkillModel>> loadSkills(String sessionId) async {
    // Load skills from db
    final List<dynamic> skillRes = await supabaseClient
        .from('skills')
        .select()
        .eq('session_id', sessionId);

    // Transform JSON to model
    final List<SkillModel> models =
        skillRes.map((json) => SkillModel.fromJson(json)).toList();

    return models;
  }
}
