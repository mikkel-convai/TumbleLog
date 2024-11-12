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
    on<MonitorLoadAllSessions>(_onLoadAllSessions);
    on<MonitorLoadSessionsForUser>(_onLoadSessionsForUser);
    on<MonitorLoadSkills>(_onLoadSkills);
  }

  Future<void> _onLoadAllSessions(
      MonitorLoadAllSessions event, Emitter<MonitorState> emit) async {
    emit(MonitorLoading());

    try {
      final List<SessionEntity> sessions = await loadSessions.execute();

      emit(MonitorStateLoaded(
        sessions: sessions,
        selectedSession: null,
        skills: const [],
      ));
    } catch (e) {
      emit(MonitorError(message: e.toString()));
    }
  }

  Future<void> _onLoadSessionsForUser(
      MonitorLoadSessionsForUser event, Emitter<MonitorState> emit) async {
    emit(MonitorLoading());

    try {
      // Fetch sessions for the specific user
      final List<SessionEntity> sessions =
          await loadSessions.execute(athleteId: event.athleteId);

      emit(MonitorStateLoaded(
        sessions: sessions,
        selectedSession: null,
        skills: const [],
      ));
    } catch (e) {
      emit(MonitorError(message: e.toString()));
    }
  }

  Future<void> _onLoadSkills(
      MonitorLoadSkills event, Emitter<MonitorState> emit) async {
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
        emit(MonitorError(message: e.toString()));
      }
    }
  }

  List<SessionEntity> getWeeklySessionsForAthlete(String athleteId) {
    final now = DateTime.now();
    final oneWeekAgo = now.subtract(const Duration(days: 7));

    // Filter sessions by both date and athlete ID
    return (state is MonitorStateLoaded)
        ? (state as MonitorStateLoaded)
            .sessions
            .where((session) =>
                session.athleteId == athleteId &&
                session.date.isAfter(oneWeekAgo) &&
                session.date.isBefore(now))
            .toList()
        : [];
  }
}
