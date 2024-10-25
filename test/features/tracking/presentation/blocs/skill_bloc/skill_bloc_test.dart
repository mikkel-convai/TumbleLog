import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/skill_bloc/skill_bloc.dart';

void main() {
  final SessionEntity mockSession = SessionEntity(
    id: 'session123', // Ensure sessionId is passed
    athleteId: 'athleteId',
    date: DateTime.now(),
  );

  final List<SkillEntity> mockSkills = [
    SkillEntity(
      id: '1',
      name: 'Whip',
      symbol: '^',
      difficulty: 0.2,
      sessionId: mockSession.id, // Add sessionId to SkillEntity
      equipmentReps: const {
        EquipmentType.rodFloor: 0,
      },
    ),
    SkillEntity(
      id: '2',
      name: 'DB tuck',
      symbol: '--o',
      difficulty: 2.0,
      sessionId: mockSession.id, // Add sessionId to SkillEntity
      equipmentReps: const {
        EquipmentType.rodFloor: 1,
      },
    ),
  ];

  group('SkillBloc', () {
    blocTest<SkillBloc, SkillState>(
      'emits SkillLoading and SkillLoaded when LoadSkill is added, and checks sessionId',
      build: () => SkillBloc(session: mockSession),
      act: (bloc) => bloc.add(LoadSkills(skills: mockSkills)),
      expect: () => <SkillState>[
        const SkillLoading(),
        SkillLoaded(
          skills: mockSkills,
          selectedEquipment: EquipmentType.rodFloor,
          session: mockSession,
        ),
      ],
      verify: (bloc) {
        final state = bloc.state as SkillLoaded;
        // Check that all skills in state have the correct sessionId
        for (var skill in state.skills) {
          expect(skill.sessionId, equals(mockSession.id));
        }
      },
    );

    blocTest<SkillBloc, SkillState>(
      'Increments number of reps for given skill and equipment, and checks sessionId',
      build: () => SkillBloc(session: mockSession),
      seed: () => SkillLoaded(
        skills: List<SkillEntity>.from(mockSkills),
        selectedEquipment: EquipmentType.rodFloor,
        session: mockSession,
      ),
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
                sessionId: mockSession.id, // Ensure sessionId is preserved
                equipmentReps: const {
                  EquipmentType.rodFloor: 1, // Incremented reps
                },
              ),
              SkillEntity(
                id: '2',
                name: 'DB tuck',
                symbol: '--o',
                difficulty: 2.0,
                sessionId: mockSession.id,
                equipmentReps: const {
                  EquipmentType.rodFloor: 1,
                },
              ),
            ],
            selectedEquipment: EquipmentType.rodFloor,
            session: mockSession,
          ),
        ];
      },
      verify: (bloc) {
        final state = bloc.state as SkillLoaded;
        for (var skill in state.skills) {
          expect(skill.sessionId, equals(mockSession.id));
        }
      },
    );

    blocTest<SkillBloc, SkillState>(
      'Decreases number of reps for a given skill and equipment, and checks sessionId',
      build: () => SkillBloc(session: mockSession),
      seed: () => SkillLoaded(
        skills: List<SkillEntity>.from(mockSkills),
        selectedEquipment: EquipmentType.rodFloor,
        session: mockSession,
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
                sessionId: mockSession.id,
                equipmentReps: const {
                  EquipmentType.rodFloor: 0,
                },
              ),
              SkillEntity(
                id: '2',
                name: 'DB tuck',
                symbol: '--o',
                difficulty: 2.0,
                sessionId: mockSession.id,
                equipmentReps: const {
                  EquipmentType.rodFloor: 0, // Decremented reps
                },
              ),
            ],
            selectedEquipment: EquipmentType.rodFloor,
            session: mockSession,
          ),
        ];
      },
      verify: (bloc) {
        final state = bloc.state as SkillLoaded;
        for (var skill in state.skills) {
          expect(skill.sessionId, equals(mockSession.id));
        }
      },
    );

    blocTest<SkillBloc, SkillState>(
      'Update number of reps for a given skill and equipment, and checks sessionId',
      build: () => SkillBloc(session: mockSession),
      seed: () => SkillLoaded(
        skills: List<SkillEntity>.from(mockSkills),
        selectedEquipment: EquipmentType.rodFloor,
        session: mockSession,
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
                sessionId: mockSession.id,
                equipmentReps: const {
                  EquipmentType.rodFloor: 10, // Updated reps
                },
              ),
              SkillEntity(
                id: '2',
                name: 'DB tuck',
                symbol: '--o',
                difficulty: 2.0,
                sessionId: mockSession.id,
                equipmentReps: const {
                  EquipmentType.rodFloor: 1,
                },
              ),
            ],
            selectedEquipment: EquipmentType.rodFloor,
            session: mockSession,
          ),
        ];
      },
      verify: (bloc) {
        final state = bloc.state as SkillLoaded;
        for (var skill in state.skills) {
          expect(skill.sessionId, equals(mockSession.id));
        }
      },
    );
  });
}
