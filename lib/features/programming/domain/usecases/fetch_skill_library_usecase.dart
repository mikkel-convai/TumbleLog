import 'package:tumblelog/core/entities/skill_library_entity.dart';
import 'package:tumblelog/core/models/skill_library_model.dart';
import 'package:tumblelog/injection_container.dart';

class FetchSkillLibraryUseCase {
  Future<List<SkillLibraryEntity>> execute(String? creatorId) async {
    final response = await supabaseClient.from('skill_library').select();

    final List<SkillLibraryModel> skillModelsList =
        response.map((json) => SkillLibraryModel.fromJson(json)).toList();

    final List<SkillLibraryEntity> skillsList = skillModelsList
        .map(
          (model) => SkillLibraryEntity(
            id: model.id,
            name: model.name,
            symbol: model.symbol,
            difficulty: model.difficulty,
            isDefault: model.isDefault,
          ),
        )
        .toList();

    return skillsList;
  }
}
