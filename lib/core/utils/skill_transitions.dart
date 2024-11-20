import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/core/entities/skill_library_entity.dart';

// Utility function to convert SkillLibraryEntity to SkillEntity
List<SkillEntity> convertToSkillEntities(
  List<SkillLibraryEntity> skillLibraryEntities,
  String sessionId,
) {
  return skillLibraryEntities.map((skillLibrary) {
    return SkillEntity(
      sessionId: sessionId,
      name: skillLibrary.name,
      symbol: skillLibrary.symbol,
      difficulty: skillLibrary.difficulty,
      equipmentReps: defaultEquipmentReps, // Assuming default reps for now
    );
  }).toList();
}

// Utility function to convert SkillEntity to SkillLibraryEntity
List<SkillLibraryEntity> convertToSkillLibraryEntities(
  List<SkillEntity> skillEntities,
) {
  return skillEntities.map((skill) {
    return SkillLibraryEntity(
      id: skill.id,
      name: skill.name,
      symbol: skill.symbol,
      difficulty: skill.difficulty,
      creatorId: null, // Assuming creatorId is unavailable here
      isDefault: false, // Assuming this is not from default skill library
    );
  }).toList();
}
