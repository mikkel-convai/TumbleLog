part of 'monitor_bloc.dart';

sealed class MonitorState extends Equatable {
  const MonitorState();

  @override
  List<Object> get props => [];
}

final class MonitorInitial extends MonitorState {}

final class MonitorLoading extends MonitorState {}

final class MonitorSessionsLoaded extends MonitorState {
  final List<SessionEntity> sessions;

  const MonitorSessionsLoaded({required this.sessions});

  @override
  List<Object> get props => [sessions];
}

final class MonitorError extends MonitorState {
  final String message;

  const MonitorError({required this.message});

  @override
  List<Object> get props => [message];
}
