part of 'monitor_bloc.dart';

sealed class MonitorEvent extends Equatable {
  const MonitorEvent();

  @override
  List<Object> get props => [];
}

final class MonitorLoadAllSessions extends MonitorEvent {
  const MonitorLoadAllSessions();
}

final class MonitorLoadAthletes extends MonitorEvent {
  final String? userClub;

  const MonitorLoadAthletes(this.userClub);
}

final class MonitorLoadSessionsForUser extends MonitorEvent {
  final String athleteId;

  const MonitorLoadSessionsForUser({required this.athleteId});

  @override
  List<Object> get props => [athleteId];
}

final class MonitorLoadSkills extends MonitorEvent {
  final String sessionId;

  const MonitorLoadSkills({required this.sessionId});

  @override
  List<Object> get props => [sessionId];
}
