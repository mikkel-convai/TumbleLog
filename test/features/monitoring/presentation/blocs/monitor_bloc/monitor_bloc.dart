import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'monitor_event.dart';
part 'monitor_state.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  MonitorBloc() : super(MonitorInitial()) {
    on<MonitorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
