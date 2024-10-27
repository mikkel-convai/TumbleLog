part of 'monitor_bloc.dart';

sealed class MonitorState extends Equatable {
  const MonitorState();
  
  @override
  List<Object> get props => [];
}

final class MonitorInitial extends MonitorState {}
