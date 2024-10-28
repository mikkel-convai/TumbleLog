import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/core/models/skill_model.dart';
import 'package:tumblelog/features/monitoring/data/datasources/skill_remote_datasource.dart';
import 'package:tumblelog/features/monitoring/domain/repositories/skill_repository.dart';

class SkillRepositoryImpl implements SkillRepository {
  final SkillRemoteDataSource remoteDataSource;

  SkillRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SkillEntity>> loadSkills(String sessionId) async {
    try {
      final List<SkillModel> skillModels =
          await remoteDataSource.loadSkills(sessionId);

      final List<SkillEntity> skills = skillModels.map((skill) {
        return SkillEntity(
          id: skill.id,
          sessionId: sessionId,
          name: skill.name,
          symbol: skill.symbol,
          difficulty: skill.difficulty,
          equipmentReps: skill.equipmentReps,
        );
      }).toList();

      return skills;
    } catch (e) {
      // TODO: Handle errors
      print('Error occured: $e');
      return [];
    }
  }
}
