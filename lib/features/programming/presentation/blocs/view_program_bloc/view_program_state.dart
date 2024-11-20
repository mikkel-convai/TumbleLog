part of 'view_program_bloc.dart';

sealed class ViewProgramState extends Equatable {
  const ViewProgramState();

  @override
  List<Object> get props => [];
}

class ViewProgramInitial extends ViewProgramState {}

class ViewProgramLoading extends ViewProgramState {}

class ViewProgramLoaded extends ViewProgramState {
  final List<ProgramEntity> programs;

  const ViewProgramLoaded({required this.programs});

  @override
  List<Object> get props => [programs];
}

class ViewProgramError extends ViewProgramState {
  final String message;

  const ViewProgramError({required this.message});

  @override
  List<Object> get props => [message];
}
