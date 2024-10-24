import 'package:flutter_test/flutter_test.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/features/tracking/domain/entities/skill_entity.dart';

void main() {
  group('SkillEntity', () {
    late SkillEntity skillEntity;

    setUp(() {
      skillEntity = SkillEntity(
        name: 'Whipback',
        symbol: '^',
        difficulty: 0.2,
      );
    });

    test('should create SkillEntity with default equipment reps', () {
      expect(skillEntity.name, 'Whipback');
      expect(skillEntity.symbol, '^');
      expect(skillEntity.difficulty, 0.2);
      expect(skillEntity.getRepsForEquipment(EquipmentType.rodFloor), 1);
      expect(skillEntity.getRepsForEquipment(EquipmentType.airRodFloor), 2);
      expect(skillEntity.getRepsForEquipment(EquipmentType.airFloor), 3);
      expect(skillEntity.getRepsForEquipment(EquipmentType.dmt), 4);
      expect(skillEntity.getRepsForEquipment(EquipmentType.trampoline), 5);
    });

    test('should return reps for a specific equipment', () {
      expect(skillEntity.getRepsForEquipment(EquipmentType.rodFloor), 1);
      expect(skillEntity.getRepsForEquipment(EquipmentType.trampoline), 5);
    });

    test('should increment reps for specific equipment', () {
      final updatedSkill =
          skillEntity.incrementRepsForEquipment(EquipmentType.rodFloor);
      expect(updatedSkill.getRepsForEquipment(EquipmentType.rodFloor), 2);
      expect(updatedSkill.getRepsForEquipment(EquipmentType.trampoline), 5);
    });

    test('should decrement reps for specific equipment', () {
      final updatedSkill =
          skillEntity.decrementRepsForEquipment(EquipmentType.trampoline);
      expect(updatedSkill.getRepsForEquipment(EquipmentType.trampoline), 4);
      expect(updatedSkill.getRepsForEquipment(EquipmentType.rodFloor), 1);
    });

    test('should not decrement reps below 0', () {
      final updatedSkill = skillEntity
          .decrementRepsForEquipment(EquipmentType.rodFloor)
          .decrementRepsForEquipment(EquipmentType.rodFloor);
      expect(updatedSkill.getRepsForEquipment(EquipmentType.rodFloor), 0);
      final furtherDecrement =
          updatedSkill.decrementRepsForEquipment(EquipmentType.rodFloor);
      expect(furtherDecrement.getRepsForEquipment(EquipmentType.rodFloor), 0);
    });

    test('should update reps for specific equipment', () {
      final updatedSkill =
          skillEntity.updateRepsForEquipment(EquipmentType.dmt, 10);
      expect(updatedSkill.getRepsForEquipment(EquipmentType.dmt), 10);
      expect(updatedSkill.getRepsForEquipment(EquipmentType.rodFloor), 1);
    });

    test('should return a new instance after incrementing reps', () {
      final updatedSkill =
          skillEntity.incrementRepsForEquipment(EquipmentType.rodFloor);
      expect(updatedSkill, isNot(equals(skillEntity)));
    });

    test('should return a new instance after decrementing reps', () {
      final updatedSkill =
          skillEntity.decrementRepsForEquipment(EquipmentType.rodFloor);
      expect(updatedSkill, isNot(equals(skillEntity)));
    });

    test('should return a new instance after updating reps', () {
      final updatedSkill =
          skillEntity.updateRepsForEquipment(EquipmentType.dmt, 10);
      expect(updatedSkill, isNot(equals(skillEntity)));
    });
  });
}
