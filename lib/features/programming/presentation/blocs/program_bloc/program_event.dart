part of 'program_bloc.dart';

sealed class ProgramEvent extends Equatable {
  const ProgramEvent();

  @override
  List<Object> get props => [];
}

class ProgramCreationInit extends ProgramEvent {
  final String? creatorId;

  const ProgramCreationInit({this.creatorId});
}

class ProgramSkillAdded extends ProgramEvent {
  final SkillLibraryEntity skill;

  const ProgramSkillAdded({required this.skill});

  @override
  List<Object> get props => [skill];
}

class ProgramSkillRemoved extends ProgramEvent {
  final SkillLibraryEntity skill;

  const ProgramSkillRemoved({required this.skill});

  @override
  List<Object> get props => [skill];
}

class SaveNewProgram extends ProgramEvent {}

class ProgramNameChanged extends ProgramEvent {
  final String programName;

  const ProgramNameChanged({required this.programName});

  @override
  List<Object> get props => [programName];
}
