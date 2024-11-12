part of 'monitor_bloc.dart';

sealed class MonitorState extends Equatable {
  const MonitorState();

  @override
  List<Object> get props => [];
}

final class MonitorInitial extends MonitorState {}

final class MonitorLoading extends MonitorState {}

final class MonitorAthletesLoaded extends MonitorState {
  final List<AppUser> athletes;

  const MonitorAthletesLoaded({required this.athletes});

  @override
  List<Object> get props => [athletes];
}

final class MonitorStateLoaded extends MonitorState {
  final List<AppUser> athletes;
  final List<SessionEntity> sessions;
  final SessionEntity? selectedSession;
  final List<SkillEntity> skills;

  const MonitorStateLoaded({
    required this.athletes,
    required this.sessions,
    required this.skills,
    this.selectedSession,
  });

  @override
  List<Object> get props => [athletes, sessions, skills]; // selectedSession
}

final class MonitorError extends MonitorState {
  final String message;

  const MonitorError({required this.message});

  @override
  List<Object> get props => [message];
}
