import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/models/athlete_program_model.dart';
import 'package:tumblelog/core/models/program_model.dart';

abstract class ProgramRemoteDataSource {
  Future<void> saveProgram(ProgramModel program);
  Future<List<ProgramModel>> fetchAllPrograms();
  Future<List<ProgramModel>> fetchUserPrograms(String userId);
  Future<void> assignProgramToAthlete(AthleteProgramModel assignment);
}

class ProgramRemoteDataSourceImpl implements ProgramRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProgramRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> saveProgram(ProgramModel program) async {
    // Using custom json functions as there are mappings to multiple tables
    // Convert the `ProgramModel` to a database map
    final programData = program.toProgramsTableMap();

    // Save the program
    final savedProgram = await supabaseClient
        .from('programs')
        .insert(programData)
        .select()
        .single();

    if (savedProgram.isNotEmpty) {
      final programId = savedProgram['id'] as String;

      // Map skills to `program_skills` entries
      final programSkills = program.mapSkillsToProgramSkills(programId);

      // Save the linked skills
      await supabaseClient.from('program_skills').insert(programSkills);
    } else {
      throw Exception('Failed to save the program');
    }
  }

  @override
  Future<List<ProgramModel>> fetchAllPrograms() async {
    try {
      final programsJson = await supabaseClient
          .from('programs')
          .select('*, program_skills(skill_library(*))');

      if (programsJson.isEmpty) {
        print('No programs available');
        return [];
      }

      final programs = programsJson
          .map((program) => ProgramModel.fromJson(program))
          .toList();

      return programs;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> assignProgramToAthlete(AthleteProgramModel assignment) async {
    try {
      final assignmentJson = assignment.toJson();
      // print(assignmentJson);
      await supabaseClient
          .from('athlete_programs')
          .upsert(assignmentJson, onConflict: 'athlete_id, program_id');
    } catch (e) {
      print('Error adding program to athlete: $e');
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProgramModel>> fetchUserPrograms(String userId) async {
    try {
      // Make this work for user programs
      final programsJson = await supabaseClient
          .from('programs')
          .select(
              '*, athlete_programs!inner(), program_skills(skill_library(*))')
          .eq('athlete_programs.athlete_id', userId);

      if (programsJson.isEmpty) {
        print('No programs available');
        return [];
      }

      final programs = programsJson
          .map((program) => ProgramModel.fromJson(program))
          .toList();

      return programs;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
