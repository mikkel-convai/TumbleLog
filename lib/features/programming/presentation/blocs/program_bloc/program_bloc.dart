import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/core/entities/program_entity.dart';
import 'package:tumblelog/core/entities/skill_library_entity.dart';
import 'package:tumblelog/features/programming/domain/usecases/fetch_skill_library_usecase.dart';
import 'package:tumblelog/features/programming/domain/usecases/save_program_usecase.dart';
import 'package:tumblelog/features/programming/presentation/blocs/view_program_bloc/view_program_bloc.dart';
import 'package:uuid/uuid.dart';

part 'program_event.dart';
part 'program_state.dart';

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  final FetchSkillLibraryUseCase fetchSkillLibrary;
  final SaveProgramUseCase saveNewProgram;

  ProgramBloc({
    required this.fetchSkillLibrary,
    required this.saveNewProgram,
  }) : super(ProgramInitial()) {
    on<ProgramCreationInit>(_onProgramCreationInit);
    on<ProgramSkillAdded>(_onSkillAdded);
    on<ProgramSkillRemoved>(_onSkillRemoved);
    on<SaveNewProgram>(_onSaveNewProgram);
    on<ProgramNameChanged>(_onProgramNameChanged);
  }

  void _onProgramNameChanged(
      ProgramNameChanged event, Emitter<ProgramState> emit) {
    if (state is ProgramCreateStateLoaded) {
      final currentState = state as ProgramCreateStateLoaded;

      // Update program name
      final updatedProgram =
          currentState.program.copyWith(name: event.programName);

      emit(currentState.copyWith(program: updatedProgram));
    }
  }

  void _onSaveNewProgram(
      SaveNewProgram event, Emitter<ProgramState> emit) async {
    final prevState = state;
    final AppUser? currentUser = event.currentUser;

    if (prevState is ProgramCreateStateLoaded) {
      emit(ProgramSaving());

      try {
        await saveNewProgram.execute(prevState.program, currentUser);
        emit(ProgramSaved());

        if (currentUser != null && event.context.mounted) {
          final viewProgramBloc = event.context.read<ViewProgramBloc>();
          viewProgramBloc.add(UpdatePrograms(program: prevState.program));
        }
      } catch (e) {
        print(e);
        emit(ProgramError(
          "Failed to save the program. Please try again.",
        ));
      }
    }
  }

  void _onSkillAdded(ProgramSkillAdded event, Emitter<ProgramState> emit) {
    if (state is ProgramCreateStateLoaded) {
      final currentState = state as ProgramCreateStateLoaded;

      // Remove the skill from skillLibrary and add it to the program's skills
      final updatedSkillLibrary =
          List<SkillLibraryEntity>.from(currentState.skillLibrary)
            ..removeWhere((skill) => skill.id == event.skill.id);

      final updatedSkills =
          List<SkillLibraryEntity>.from(currentState.program.skills)
            ..add(event.skill);

      final updatedProgram =
          currentState.program.copyWith(skills: updatedSkills);

      emit(currentState.copyWith(
        skillLibrary: updatedSkillLibrary,
        program: updatedProgram,
      ));
    }
  }

  void _onSkillRemoved(ProgramSkillRemoved event, Emitter<ProgramState> emit) {
    if (state is ProgramCreateStateLoaded) {
      final currentState = state as ProgramCreateStateLoaded;

      // Remove the skill from the program's skills and add it back to the skill library
      final updatedSkills =
          List<SkillLibraryEntity>.from(currentState.program.skills)
            ..removeWhere((skill) => skill.id == event.skill.id);

      final updatedSkillLibrary =
          List<SkillLibraryEntity>.from(currentState.skillLibrary)
            ..add(event.skill);

      final updatedProgram =
          currentState.program.copyWith(skills: updatedSkills);

      emit(currentState.copyWith(
        skillLibrary: updatedSkillLibrary,
        program: updatedProgram,
      ));
    }
  }

  Future<void> _onProgramCreationInit(
      ProgramCreationInit event, Emitter<ProgramState> emit) async {
    emit(ProgramLoading());

    try {
      final List<SkillLibraryEntity> skillLibrary =
          await fetchSkillLibrary.execute(event.creatorId);

      // Initialize the program with an empty name and no skills
      final ProgramEntity initialProgram = ProgramEntity(
        id: const Uuid().v4(),
        name: '',
        skills: const [],
        creatorId: event.creatorId,
      );

      emit(ProgramCreateStateLoaded(
        skillLibrary: skillLibrary,
        program: initialProgram,
      ));
    } catch (e) {
      emit(ProgramError(
        "Failed to load skill library. Please try again.",
      ));
    }
  }
}
