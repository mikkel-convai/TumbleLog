import 'package:tumblelog/core/entities/athlete_program_entity.dart';
import 'package:tumblelog/features/programming/domain/repositories/program_repository.dart';

class AssignProgramToAthleteUseCase {
  final ProgramRepository repository;

  AssignProgramToAthleteUseCase({required this.repository});

  Future<void> execute(AthleteProgramEntity assignment) async {
    repository.assignProgramToAthlete(assignment);
  }
}
