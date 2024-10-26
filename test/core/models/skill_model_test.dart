import 'package:flutter_test/flutter_test.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/models/skill_model.dart';

void main() {
  group('SkillModel', () {
    const skillModel = SkillModel(
      id: '1',
      sessionId: 'session123',
      name: 'Whip',
      symbol: '^',
      difficulty: 0.5,
      equipmentReps: {
        EquipmentType.rodFloor: 3,
      },
    );

    final skillJson = {
      'id': '1',
      'sessionId': 'session123',
      'name': 'Whip',
      'symbol': '^',
      'difficulty': 0.5,
      'equipmentReps': {
        'rodFloor': 3,
      },
    };

    test('should correctly convert from JSON', () {
      final result = SkillModel.fromJson(skillJson);
      expect(result, skillModel);
    });

    test('should correctly convert to JSON', () {
      final result = skillModel.toJson();
      expect(result, skillJson);
    });

    test('should support value equality', () {
      const otherSkill = SkillModel(
        id: '1',
        sessionId: 'session123',
        name: 'Whip',
        symbol: '^',
        difficulty: 0.5,
        equipmentReps: {
          EquipmentType.rodFloor: 3,
        },
      );
      expect(skillModel, equals(otherSkill));
    });

    test('should have correct props', () {
      expect(skillModel.props, [
        skillModel.id,
        skillModel.sessionId,
        skillModel.name,
        skillModel.symbol,
        skillModel.difficulty,
        skillModel.equipmentReps,
      ]);
    });
  });
}
