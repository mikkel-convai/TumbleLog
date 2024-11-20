import 'package:tumblelog/core/entities/program_entity.dart';
import 'package:tumblelog/features/programming/domain/repositories/program_repository.dart';

class FetchAllProgramsUseCase {
  final ProgramRepository repository;

  FetchAllProgramsUseCase({required this.repository});

  Future<List<ProgramEntity>> execute() async {
    return await repository.fetchAllPrograms();
  }
}
