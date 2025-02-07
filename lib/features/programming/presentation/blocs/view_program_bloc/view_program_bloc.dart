import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumblelog/core/entities/program_entity.dart';
import 'package:tumblelog/features/programming/domain/usecases/fetch_user_programs_usecase.dart';

part 'view_program_event.dart';
part 'view_program_state.dart';

class ViewProgramBloc extends Bloc<ViewProgramEvent, ViewProgramState> {
  final FetchUserProgramsUseCase fetchProgramsUseCase;

  ViewProgramBloc({required this.fetchProgramsUseCase})
      : super(ViewProgramInitial()) {
    on<LoadPrograms>(_onLoadPrograms);
    on<UpdatePrograms>(_onUpdatePrograms);
  }

  Future<void> _onLoadPrograms(
      LoadPrograms event, Emitter<ViewProgramState> emit) async {
    emit(ViewProgramLoading());
    try {
      final programs = await fetchProgramsUseCase.execute(event.userId);
      emit(ViewProgramLoaded(programs: programs));
    } catch (e) {
      emit(ViewProgramError(
          message: 'Failed to load programs: ${e.toString()}'));
    }
  }

  Future<void> _onUpdatePrograms(
      UpdatePrograms event, Emitter<ViewProgramState> emit) async {
    final prevState = state;
    emit(ViewProgramLoading());

    try {
      if (prevState is ViewProgramLoaded) {
        // Add the new program to the list
        final updatedPrograms = List<ProgramEntity>.from(prevState.programs)
          ..add(event.program);

        emit(ViewProgramLoaded(programs: updatedPrograms));
      }
    } catch (e) {
      emit(ViewProgramError(
          message: 'Failed to load programs: ${e.toString()}'));
    }
  }
}
