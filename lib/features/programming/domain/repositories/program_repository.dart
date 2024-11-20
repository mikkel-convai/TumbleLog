import 'package:tumblelog/core/entities/athlete_program_entity.dart';
import 'package:tumblelog/core/entities/program_entity.dart';

abstract class ProgramRepository {
  Future<void> saveProgram(ProgramEntity program);
  Future<List<ProgramEntity>> fetchAllPrograms();
  Future<List<ProgramEntity>> fetchUserPrograms(String userId);
  Future<void> assignProgramToAthlete(AthleteProgramEntity assignment);
}
