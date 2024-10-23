// import 'package:tumblelog/features/tracking/domain/entities/equipment_rep_entity.dart';

// class SkillEntity {
//   final String id;
//   final String name;
//   final String symbol;
//   final double difficulty;
//   List<EquipmentRepEntity> equipmentReps;

//   SkillEntity({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.difficulty,
//     List<EquipmentRepEntity>? equipmentReps,
//   }) : equipmentReps = equipmentReps ?? [];
// }

class SkillEntity {
  final String name;
  final DateTime date;
  final String symbol;
  final double difficulty;
  final String equipment;
  int reps;

  SkillEntity({
    required this.name,
    required this.symbol,
    this.difficulty = 0.0,
    DateTime? date,
    this.equipment = 'rod floor',
    this.reps = 0,
  }) : date = date ?? DateTime.now();
}
