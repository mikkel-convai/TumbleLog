import 'package:tumblelog/core/entities/athlete_program_entity.dart';
import 'package:tumblelog/core/entities/program_entity.dart';
import 'package:tumblelog/core/entities/skill_library_entity.dart';
import 'package:tumblelog/core/models/athlete_program_model.dart';
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

  @override
  Future<List<ProgramEntity>> fetchAllPrograms() async {
    try {
      // Fetch the programs as models from the remote data source
      final programModels = await remoteDataSource.fetchAllPrograms();

      // Map ProgramModel to ProgramEntity
      final programEntities = programModels.map((programModel) {
        return ProgramEntity(
          id: programModel.id,
          name: programModel.name,
          creatorId: programModel.creatorId,
          skills: programModel.skills.map((skillModel) {
            return SkillLibraryEntity(
              id: skillModel.id,
              name: skillModel.name,
              symbol: skillModel.symbol,
              difficulty: skillModel.difficulty,
              creatorId: skillModel.creatorId,
              isDefault: skillModel.isDefault,
            );
          }).toList(),
        );
      }).toList();

      return programEntities;
    } catch (e) {
      print('Error transforming programs: $e');
      throw Exception('Failed to fetch and transform programs');
    }
  }

  @override
  Future<void> assignProgramToAthlete(AthleteProgramEntity assignment) async {
    final model = AthleteProgramModel(
      athleteId: assignment.athleteId,
      programId: assignment.programId,
    );
    await remoteDataSource.assignProgramToAthlete(model);
  }

  @override
  Future<List<ProgramEntity>> fetchUserPrograms(String userId) async {
    try {
      // Fetch the programs as models from the remote data source
      final programModels = await remoteDataSource.fetchUserPrograms(userId);

      // Map ProgramModel to ProgramEntity
      final programEntities = programModels.map((programModel) {
        return ProgramEntity(
          id: programModel.id,
          name: programModel.name,
          creatorId: programModel.creatorId,
          skills: programModel.skills.map((skillModel) {
            return SkillLibraryEntity(
              id: skillModel.id,
              name: skillModel.name,
              symbol: skillModel.symbol,
              difficulty: skillModel.difficulty,
              creatorId: skillModel.creatorId,
              isDefault: skillModel.isDefault,
            );
          }).toList(),
        );
      }).toList();

      return programEntities;
    } catch (e) {
      print('Error transforming programs: $e');
      throw Exception('Failed to fetch and transform programs');
    }
  }
}
