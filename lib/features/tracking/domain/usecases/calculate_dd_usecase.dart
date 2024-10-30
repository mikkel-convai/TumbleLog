import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';

class CalculateDdUseCase {
  // Calculate total difficulty degree (dd) for a session based on the list of skills
  double calculateTotalDd(List<SkillEntity> skills) {
    return skills.fold(
        0.0,
        (sum, skill) =>
            sum +
            (skill.difficulty *
                skill.equipmentReps.values.fold(0, (a, b) => a + b)));
  }

  // Calculate difficulty degree (dd) per equipment
  Map<EquipmentType, double> calculateEquipmentDd(List<SkillEntity> skills) {
    final Map<EquipmentType, double> equipmentDd = {};

    for (var skill in skills) {
      for (var entry in skill.equipmentReps.entries) {
        final equipment = entry.key;
        final reps = entry.value;

        // Calculate dd contribution for each equipment based on skill difficulty and reps
        final ddContribution = skill.difficulty * reps;
        equipmentDd.update(
          equipment,
          (existingDd) => existingDd + ddContribution,
          ifAbsent: () => ddContribution,
        );
      }
    }

    return equipmentDd;
  }

  // Calculate and return a SessionEntity with updated dd values
  SessionEntity addSessionDd({
    required String sessionId,
    required String athleteId,
    required String athleteName,
    required DateTime date,
    required List<SkillEntity> skills,
  }) {
    final totalDd = calculateTotalDd(skills);
    final equipmentDd = calculateEquipmentDd(skills);

    return SessionEntity(
      id: sessionId,
      athleteId: athleteId,
      athleteName: athleteName,
      date: date,
      totalDd: totalDd,
      equipmentDd: equipmentDd,
    );
  }
}
