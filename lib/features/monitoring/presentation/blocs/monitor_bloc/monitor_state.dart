part of 'monitor_bloc.dart';

sealed class MonitorState extends Equatable {
  const MonitorState();

  @override
  List<Object> get props => [];
}

final class MonitorInitial extends MonitorState {}

final class MonitorLoading extends MonitorState {}

final class MonitorStateLoaded extends MonitorState {
  final List<SessionEntity> sessions;
  final SessionEntity? selectedSession;
  final List<SkillEntity> skills;

  const MonitorStateLoaded({
    required this.sessions,
    required this.skills,
    this.selectedSession,
  });

  @override
  List<Object> get props => [sessions, skills]; // selectedSession
}

final class MonitorError extends MonitorState {
  final String message;

  const MonitorError({required this.message});

  @override
  List<Object> get props => [message];
}
