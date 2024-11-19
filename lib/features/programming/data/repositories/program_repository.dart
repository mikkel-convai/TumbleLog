import 'package:tumblelog/core/entities/program_entity.dart';
import 'package:tumblelog/core/models/program_model.dart';
import 'package:tumblelog/core/models/skill_library_model.dart';
import 'package:tumblelog/features/programming/data/datasources/program_remote_datasource.dart';
import 'package:tumblelog/features/programming/domain/repositories/program_repository.dart';

class ProgramRepositoryImpl implements ProgramRepository {
  final ProgramRemoteDataSource remoteDataSource;

  ProgramRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> saveProgram(ProgramEntity program) async {
    final skills = program.skills
        .map(
          (skill) => SkillLibraryModel(
            id: skill.id,
            name: skill.name,
            symbol: skill.symbol,
            difficulty: skill.difficulty,
            isDefault: skill.isDefault,
          ),
        )
        .toList();

    final model = ProgramModel(
      id: program.id,
      name: program.name,
      creatorId: program.creatorId,
      skills: skills,
    );

    await remoteDataSource.saveProgram(model);
  }
}
