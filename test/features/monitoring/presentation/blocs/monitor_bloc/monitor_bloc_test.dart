import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/core/utils/json_to_session_model.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';

import '../../../domain/usecases/load_session.mocks.dart';
import '../../../domain/usecases/load_skills.mocks.dart';

void main() {
  late MonitorBloc monitorBloc;
  late MockLoadSessionsUseCase mockLoadSessionsUseCase;
  late MockLoadSkillsUseCase mockLoadSkillsUseCase;

  setUp(() {
    mockLoadSessionsUseCase = MockLoadSessionsUseCase();
    mockLoadSkillsUseCase = MockLoadSkillsUseCase();
    monitorBloc = MonitorBloc(
      loadSessions: mockLoadSessionsUseCase,
      loadSkills: mockLoadSkillsUseCase,
    );
  });

  tearDown(() {
    monitorBloc.close();
  });

  group('MonitorBloc', () {
    final mockSessionEntities =
        parseSessionEntitiesFromString(defaultSessionJson);
    const String mockSessionId = 'c34451aa-0c1a-40a5-9ccf-9844b9cf0245';
    final List<SkillEntity> mockSkills = [
      SkillEntity(
          sessionId: mockSessionId,
          name: 'dbs',
          symbol: '--/',
          difficulty: 2.4),
      SkillEntity(
          sessionId: mockSessionId,
          name: 'dbt',
          symbol: '--o',
          difficulty: 2.0),
    ];

    blocTest<MonitorBloc, MonitorState>(
      'emits [MonitorLoading, MonitorSessionsLoaded] when MonitorLoadSessions is added and succeeds',
      build: () {
        // Mock the use case to return testSessions when executed
        when(mockLoadSessionsUseCase.execute())
            .thenAnswer((_) async => mockSessionEntities);
        return monitorBloc;
      },
      act: (bloc) => bloc.add(const MonitorLoadSessions()),
      expect: () => [
        MonitorLoading(),
        MonitorStateLoaded(sessions: mockSessionEntities, skills: const []),
      ],
      verify: (_) {
        verify(mockLoadSessionsUseCase.execute()).called(1);
      },
    );

    blocTest<MonitorBloc, MonitorState>(
      'emits [MonitorLoading, MonitorError] when MonitorLoadSessions is added and fails',
      build: () {
        // Mock the use case to throw an exception when executed
        when(mockLoadSessionsUseCase.execute())
            .thenThrow(Exception('Failed to load sessions'));
        return monitorBloc;
      },
      act: (bloc) => bloc.add(const MonitorLoadSessions()),
      expect: () => [
        MonitorLoading(),
        const MonitorError(message: 'Exception: Failed to load sessions'),
      ],
      verify: (_) {
        verify(mockLoadSessionsUseCase.execute()).called(1);
      },
    );

    blocTest<MonitorBloc, MonitorState>(
      'emits [MonitorLoading, MonitorStateLoaded] when MonitorLoadSkills is added and succeeds',
      build: () {
        // Set up the mock to return the predefined skills for the session ID
        when(mockLoadSessionsUseCase.execute())
            .thenAnswer((_) async => mockSessionEntities);
        when(mockLoadSkillsUseCase.execute(mockSessionId))
            .thenAnswer((_) async => mockSkills);

        return monitorBloc;
      },
      seed: () {
        // Seed the initial state to simulate sessions already loaded
        return MonitorStateLoaded(
          sessions: mockSessionEntities,
          selectedSession: null,
          skills: const [],
        );
      },
      act: (bloc) =>
          bloc.add(const MonitorLoadSkills(sessionId: mockSessionId)),
      expect: () => [
        MonitorLoading(),
        MonitorStateLoaded(
          sessions: mockSessionEntities,
          selectedSession: mockSessionEntities
              .firstWhere((session) => session.id == mockSessionId),
          skills: mockSkills,
        ),
      ],
      verify: (_) {
        verify(mockLoadSkillsUseCase.execute(mockSessionId)).called(1);
      },
    );

    // TODO: Add error test
  });
}
