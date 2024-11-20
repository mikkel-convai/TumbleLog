import 'package:tumblelog/core/entities/program_entity.dart';
import 'package:tumblelog/features/programming/domain/repositories/program_repository.dart';

class FetchUserProgramsUseCase {
  final ProgramRepository repository;

  FetchUserProgramsUseCase({required this.repository});

  Future<List<ProgramEntity>> execute(String userId) async {
    return await repository.fetchUserPrograms(userId);
  }
}
