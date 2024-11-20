part of 'assign_program_bloc.dart';

abstract class AssignProgramState extends Equatable {
  const AssignProgramState();

  @override
  List<Object?> get props => [];
}

class AssignProgramInitial extends AssignProgramState {}

class AssignProgramLoading extends AssignProgramState {}

class AssignProgramLoaded extends AssignProgramState {
  final List<AppUser> athletes;
  final List<ProgramEntity> programs;

  const AssignProgramLoaded({
    required this.athletes,
    required this.programs,
  });

  @override
  List<Object?> get props => [athletes, programs];
}

class AssignProgramSuccess extends AssignProgramState {}

class AssignProgramError extends AssignProgramState {
  final String message;

  const AssignProgramError(this.message);

  @override
  List<Object?> get props => [message];
}
