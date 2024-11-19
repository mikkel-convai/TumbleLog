import 'package:tumblelog/core/entities/program_entity.dart';

abstract class ProgramRepository {
  Future<void> saveProgram(ProgramEntity program);
}
