part of 'assign_program_bloc.dart';

sealed class AssignProgramEvent extends Equatable {
  const AssignProgramEvent();

  @override
  List<Object?> get props => [];
}

class LoadAssignProgramData extends AssignProgramEvent {
  final String? clubId;

  const LoadAssignProgramData(this.clubId);

  @override
  List<Object?> get props => [clubId];
}

class AssignProgramToAthlete extends AssignProgramEvent {
  final String athleteId;
  final String programId;

  const AssignProgramToAthlete({
    required this.athleteId,
    required this.programId,
  });

  @override
  List<Object?> get props => [athleteId, programId];
}
