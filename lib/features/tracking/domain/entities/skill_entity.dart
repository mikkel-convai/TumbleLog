import 'package:equatable/equatable.dart';
import 'package:tumblelog/constants.dart';
import 'package:uuid/uuid.dart';

class SkillEntity extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final double difficulty;
  final Map<EquipmentType, int> equipmentReps;

  SkillEntity({
    String? id,
    required this.name,
    required this.symbol,
    required this.difficulty,
    Map<EquipmentType, int>? equipmentReps,
  })  : id = id ?? const Uuid().v4(),
        equipmentReps = equipmentReps ??
            {
              EquipmentType.rodFloor: 0,
              EquipmentType.airRodFloor: 0,
              EquipmentType.airFloor: 0,
              EquipmentType.dmt: 0,
              EquipmentType.trampoline: 0,
            };

  // Get reps for a specific equipment
  int getRepsForEquipment(EquipmentType equipment) {
    return equipmentReps[equipment] ?? 0;
  }

  // Create a new instance of SkillEntity with incremented reps for a specific equipment
  SkillEntity incrementRepsForEquipment(EquipmentType equipment) {
    final updatedReps = Map<EquipmentType, int>.from(equipmentReps)
      ..update(equipment, (reps) => reps + 1, ifAbsent: () => 1);
    return SkillEntity(
      id: id,
      name: name,
      symbol: symbol,
      difficulty: difficulty,
      equipmentReps: updatedReps,
    );
  }

  // Create a new instance of SkillEntity with decremented reps for a specific equipment
  SkillEntity decrementRepsForEquipment(EquipmentType equipment) {
    final updatedReps = Map<EquipmentType, int>.from(equipmentReps)
      ..update(equipment, (reps) => reps > 0 ? reps - 1 : 0);
    return SkillEntity(
      id: id,
      name: name,
      symbol: symbol,
      difficulty: difficulty,
      equipmentReps: updatedReps,
    );
  }

  // Create a new instance of SkillEntity with updated reps for a specific equipment
  SkillEntity updateRepsForEquipment(EquipmentType equipment, int newReps) {
    final updatedReps = Map<EquipmentType, int>.from(equipmentReps)
      ..[equipment] = newReps;
    return SkillEntity(
      id: id,
      name: name,
      symbol: symbol,
      difficulty: difficulty,
      equipmentReps: updatedReps,
    );
  }

  // Overrides for Equatable to compare fields for equality
  @override
  List<Object?> get props => [id, name, symbol, difficulty, equipmentReps];
}
