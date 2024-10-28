import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_skills.dart';

import '../../data/repositories/skill_repository.mocks.dart';

void main() {
  late final MockSkillRepositoryImpl repository;
  late final LoadSkillsUseCase loadSkills;
  const String mockSessionId = 'sessionid';
  final List<SkillEntity> mockSkills = [
    SkillEntity(
      id: '1',
      sessionId: mockSessionId,
      name: 'name',
      symbol: 'symbol',
      difficulty: 1,
      equipmentReps: const {EquipmentType.rodFloor: 1},
    ),
    SkillEntity(
      id: '2',
      sessionId: mockSessionId,
      name: 'name',
      symbol: 'symbol',
      difficulty: 3,
      equipmentReps: const {EquipmentType.rodFloor: 1},
    ),
  ];

  setUp(() {
    repository = MockSkillRepositoryImpl();
    loadSkills = LoadSkillsUseCase(repository: repository);
  });

  test('Should call repo.loadSkills and return list of skills', () async {
    // Arrange
    when(repository.loadSkills(mockSessionId))
        .thenAnswer((_) async => mockSkills);

    // Act
    final List<SkillEntity> skills = await loadSkills.execute(mockSessionId);

    // Assert
    verify(repository.loadSkills(mockSessionId)).called(1);
    expect(skills, isA<List<SkillEntity>>());
  });
}
