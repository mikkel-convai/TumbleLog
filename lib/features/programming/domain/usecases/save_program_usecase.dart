import 'package:tumblelog/core/entities/program_entity.dart';
import 'package:tumblelog/features/programming/domain/repositories/program_repository.dart';

class SaveProgramUseCase {
  final ProgramRepository repository;

  const SaveProgramUseCase({required this.repository});

  Future<void> execute(ProgramEntity program) async {
    await repository.saveProgram(program);
  }
}
