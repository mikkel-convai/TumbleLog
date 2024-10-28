import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/core/models/skill_model.dart';
import 'package:tumblelog/features/monitoring/data/repositories/skill_repository.dart';

import '../datasources/remote_data_source.mocks.dart';

void main() {
  late final SkillRepositoryImpl repository;
  late final MockSkillRemoteDataSourceImpl remoteDataSource;

  setUp(
    () {
      remoteDataSource = MockSkillRemoteDataSourceImpl();
      repository = SkillRepositoryImpl(remoteDataSource: remoteDataSource);
    },
  );

  group('SkillRepository', () {
    const String mockSessionId = 'sessionId';
    final List<SkillModel> mockModels = [
      const SkillModel(
        id: '1',
        sessionId: mockSessionId,
        name: 'name',
        symbol: 'symbol',
        difficulty: 1,
        equipmentReps: {EquipmentType.rodFloor: 1},
      ),
      const SkillModel(
        id: '2',
        sessionId: mockSessionId,
        name: 'name',
        symbol: 'symbol',
        difficulty: 3,
        equipmentReps: {EquipmentType.rodFloor: 1},
      ),
    ];

    test('should call remote data source and transform skills to entities',
        () async {
      // Assign
      final List<SkillEntity> expectedEntities = [
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
      when(remoteDataSource.loadSkills(mockSessionId))
          .thenAnswer((_) async => mockModels);

      // Act
      final List<SkillEntity> skills =
          await repository.loadSkills(mockSessionId);

      // Assert
      verify(remoteDataSource.loadSkills(mockSessionId)).called(1);
      expect(skills, expectedEntities);
    });
  });
}
