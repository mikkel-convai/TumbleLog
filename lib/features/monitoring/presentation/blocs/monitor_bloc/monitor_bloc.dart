import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_sessions.dart';

part 'monitor_event.dart';
part 'monitor_state.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  final LoadSessionsUseCase loadSessions;

  MonitorBloc({required this.loadSessions}) : super(MonitorInitial()) {
    on<MonitorLoadSessions>((event, emit) async {
      emit(MonitorLoading());

      try {
        final List<SessionEntity> sessions = await loadSessions.execute();

        emit(MonitorSessionsLoaded(sessions: sessions));
        print(state);
      } catch (e) {
        emit(MonitorError(message: e.toString()));
      }
    });
  }
}
