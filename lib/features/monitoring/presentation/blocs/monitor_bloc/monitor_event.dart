part of 'monitor_bloc.dart';

sealed class MonitorEvent extends Equatable {
  const MonitorEvent();

  @override
  List<Object> get props => [];
}

final class MonitorLoadSessions extends MonitorEvent {
  const MonitorLoadSessions();
}
