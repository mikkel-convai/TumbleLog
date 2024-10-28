import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_sessions.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_skills.dart';

part 'monitor_event.dart';
part 'monitor_state.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  final LoadSessionsUseCase loadSessions;
  final LoadSkillsUseCase loadSkills;

  MonitorBloc({
    required this.loadSessions,
    required this.loadSkills,
  }) : super(MonitorInitial()) {
    on<MonitorLoadSessions>((event, emit) async {
      emit(MonitorLoading());

      try {
        final List<SessionEntity> sessions = await loadSessions.execute();

        emit(MonitorStateLoaded(
          sessions: sessions,
          selectedSession: null,
          skills: const [],
        ));

        print('MonitorBloc State after MonitorLoadSession: \n $state');
      } catch (e) {
        emit(MonitorError(message: e.toString()));
      }
    });

    on<MonitorLoadSkills>(
      (event, emit) async {
        final currentState = state;
        if (currentState is MonitorStateLoaded) {
          emit(MonitorLoading());

          try {
            // Fetch skills for the selected session
            final List<SkillEntity> skills =
                await loadSkills.execute(event.sessionId);

            // Update the state with loaded skills and set the selected session
            final selectedSession = currentState.sessions
                .firstWhere((session) => session.id == event.sessionId);

            emit(MonitorStateLoaded(
              sessions: currentState.sessions,
              selectedSession: selectedSession,
              skills: skills,
            ));
          } catch (e) {
            // TODO: Handle errors
            print('Error occured in Load skills bloc: $e');
          }
        }
      },
    );
  }
}
