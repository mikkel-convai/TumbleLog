import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tumblelog/core/models/program_model.dart';

abstract class ProgramRemoteDataSource {
  Future<void> saveProgram(ProgramModel program);
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
}
