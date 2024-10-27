import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/utils/json_to_session_model.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';

import '../../../domain/usecases/load_session.mocks.dart';

void main() {
  late MonitorBloc monitorBloc;
  late MockLoadSessionsUseCase mockLoadSessionsUseCase;

  setUp(() {
    mockLoadSessionsUseCase = MockLoadSessionsUseCase();
    monitorBloc = MonitorBloc(loadSessions: mockLoadSessionsUseCase);
  });

  tearDown(() {
    monitorBloc.close();
  });

  group('MonitorBloc', () {
    final testSessionEntities =
        parseSessionEntitiesFromString(defaultSessionJson);

    blocTest<MonitorBloc, MonitorState>(
      'emits [MonitorLoading, MonitorSessionsLoaded] when MonitorLoadSessions is added and succeeds',
      build: () {
        // Mock the use case to return testSessions when executed
        when(mockLoadSessionsUseCase.execute())
            .thenAnswer((_) async => testSessionEntities);
        return monitorBloc;
      },
      act: (bloc) => bloc.add(const MonitorLoadSessions()),
      expect: () => [
        MonitorLoading(),
        MonitorSessionsLoaded(sessions: testSessionEntities),
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
  });
}
