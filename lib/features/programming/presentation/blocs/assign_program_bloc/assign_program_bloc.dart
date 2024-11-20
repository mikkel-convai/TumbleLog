import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumblelog/core/entities/app_user_entity.dart';
import 'package:tumblelog/core/entities/athlete_program_entity.dart';
import 'package:tumblelog/core/entities/program_entity.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_athletes.dart';
import 'package:tumblelog/features/programming/domain/usecases/assign_program_to_athlete_usecase.dart';
import 'package:tumblelog/features/programming/domain/usecases/fetch_all_programs_usecase.dart';

part 'assign_program_event.dart';
part 'assign_program_state.dart';

class AssignProgramBloc extends Bloc<AssignProgramEvent, AssignProgramState> {
  final LoadAthletesUseCase fetchAthletesUseCase;
  final FetchAllProgramsUseCase fetchAllProgramsUseCase;
  final AssignProgramToAthleteUseCase assignProgramToAthleteUseCase;

  AssignProgramBloc({
    required this.fetchAthletesUseCase,
    required this.fetchAllProgramsUseCase,
    required this.assignProgramToAthleteUseCase,
  }) : super(AssignProgramInitial()) {
    on<LoadAssignProgramData>(_onLoadAssignProgramData);
    on<AssignProgramToAthlete>(_onAssignProgram);
  }

  Future<void> _onLoadAssignProgramData(
      LoadAssignProgramData event, Emitter<AssignProgramState> emit) async {
    emit(AssignProgramLoading());
    try {
      // TODO: Consider: is it legit to use the LoadAthletesUseCase?
      // It is from a different feature and needs clubId
      final athletes = await fetchAthletesUseCase.execute(event.clubId);
      final programs = await fetchAllProgramsUseCase.execute();
      emit(AssignProgramLoaded(athletes: athletes, programs: programs));
    } catch (e) {
      emit(AssignProgramError(e.toString()));
    }
  }

  Future<void> _onAssignProgram(
      AssignProgramToAthlete event, Emitter<AssignProgramState> emit) async {
    final prevState = state;
    try {
      await assignProgramToAthleteUseCase.execute(
        AthleteProgramEntity(
          athleteId: event.athleteId,
          programId: event.programId,
        ),
      );
      emit(AssignProgramSuccess());
      emit(prevState);
    } catch (e) {
      emit(AssignProgramError(e.toString()));
    }
  }
}
