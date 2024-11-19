part of 'program_bloc.dart';

sealed class ProgramState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProgramInitial extends ProgramState {}

class ProgramLoading extends ProgramState {}

class ProgramCreateStateLoaded extends ProgramState {
  final List<SkillLibraryEntity> skillLibrary;
  final ProgramEntity program;

  ProgramCreateStateLoaded({required this.skillLibrary, required this.program});

  @override
  List<Object?> get props => [skillLibrary, program];

  ProgramCreateStateLoaded copyWith({
    List<SkillLibraryEntity>? skillLibrary,
    ProgramEntity? program,
  }) {
    return ProgramCreateStateLoaded(
      skillLibrary: skillLibrary ?? this.skillLibrary,
      program: program ?? this.program,
    );
  }
}

class ProgramSaving extends ProgramState {}

class ProgramSaved extends ProgramState {}

class ProgramError extends ProgramState {
  final String message;

  ProgramError(this.message);

  @override
  List<Object?> get props => [message];
}
