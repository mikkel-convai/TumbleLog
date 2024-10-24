import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/features/tracking/domain/entities/skill_entity.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/skill_bloc/skill_bloc.dart';

void main() {
  final List<SkillEntity> mockSkills = [
    SkillEntity(
        id: '1',
        name: 'Whip',
        symbol: '^',
        difficulty: 0.2,
        equipmentReps: const {
          EquipmentType.rodFloor: 0,
        }),
    SkillEntity(
        id: '2',
        name: 'DB tuck',
        symbol: '--o',
        difficulty: 2.0,
        equipmentReps: const {
          EquipmentType.rodFloor: 1,
        }),
  ];
  // mapJsonToSkillEntities(defaultSkillsJson);

  group('SkillBloc', () {
    blocTest<SkillBloc, SkillState>(
      'emits SkillLoading and SkillLoaded when LoadSkill is added.',
      build: () => SkillBloc(),
      act: (bloc) => bloc.add(LoadSkills(skills: mockSkills)),
      expect: () => <SkillState>[
        const SkillLoading(),
        SkillLoaded(
          skills: mockSkills,
          selectedEquipment: EquipmentType.rodFloor,
        )
      ],
    );

    blocTest<SkillBloc, SkillState>(
        'Increments number of reps for given skill and equipment',
        build: () => SkillBloc(),
        seed: () => SkillLoaded(
            skills: List<SkillEntity>.from(mockSkills),
            selectedEquipment: EquipmentType.rodFloor),
        act: (bloc) => bloc.add(IncrementReps('1', EquipmentType.rodFloor)),
        expect: () {
          return [
            SkillLoaded(
              skills: [
                SkillEntity(
                    id: '1',
                    name: 'Whip',
                    symbol: '^',
                    difficulty: 0.2,
                    equipmentReps: const {
                      EquipmentType.rodFloor: 1,
                    }),
                SkillEntity(
                    id: '2',
                    name: 'DB tuck',
                    symbol: '--o',
                    difficulty: 2.0,
                    equipmentReps: const {
                      EquipmentType.rodFloor: 1,
                    }),
              ],
              selectedEquipment: EquipmentType.rodFloor,
            ),
          ];
        });

    blocTest<SkillBloc, SkillState>(
      'Decreases number of reps for a given skill and equipment',
      build: () => SkillBloc(),
      seed: () => SkillLoaded(
        skills: List<SkillEntity>.from(mockSkills),
        selectedEquipment: EquipmentType.rodFloor,
      ),
      act: (bloc) => bloc.add(DecrementReps('2', EquipmentType.rodFloor)),
      expect: () {
        return [
          SkillLoaded(
            skills: [
              SkillEntity(
                  id: '1',
                  name: 'Whip',
                  symbol: '^',
                  difficulty: 0.2,
                  equipmentReps: const {
                    EquipmentType.rodFloor: 0,
                  }),
              SkillEntity(
                  id: '2',
                  name: 'DB tuck',
                  symbol: '--o',
                  difficulty: 2.0,
                  equipmentReps: const {
                    EquipmentType.rodFloor: 0,
                  }),
            ],
            selectedEquipment: EquipmentType.rodFloor,
          ),
        ];
      },
    );

    blocTest<SkillBloc, SkillState>(
      'Update number of reps for a given skill and equipment',
      build: () => SkillBloc(),
      seed: () => SkillLoaded(
        skills: List<SkillEntity>.from(mockSkills),
        selectedEquipment: EquipmentType.rodFloor,
      ),
      act: (bloc) => bloc.add(UpdateReps('1', EquipmentType.rodFloor, 10)),
      expect: () {
        return [
          SkillLoaded(
            skills: [
              SkillEntity(
                  id: '1',
                  name: 'Whip',
                  symbol: '^',
                  difficulty: 0.2,
                  equipmentReps: const {
                    EquipmentType.rodFloor: 10,
                  }),
              SkillEntity(
                  id: '2',
                  name: 'DB tuck',
                  symbol: '--o',
                  difficulty: 2.0,
                  equipmentReps: const {
                    EquipmentType.rodFloor: 1,
                  }),
            ],
            selectedEquipment: EquipmentType.rodFloor,
          ),
        ];
      },
    );

    blocTest<SkillBloc, SkillState>(
      'emits updated selectedEquipment when ChangeEquipment is added',
      build: () => SkillBloc(),
      seed: () => SkillLoaded(
          skills: mockSkills, selectedEquipment: EquipmentType.rodFloor),
      act: (bloc) => bloc.add(ChangeEquipment(EquipmentType.trampoline)),
      expect: () => [
        SkillLoaded(
            skills: mockSkills, selectedEquipment: EquipmentType.trampoline),
      ],
    );
  });
}
