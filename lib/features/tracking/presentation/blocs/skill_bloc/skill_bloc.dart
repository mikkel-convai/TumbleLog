import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/utils/json_to_skill_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/features/tracking/domain/usecases/save_session_usecase.dart';

part 'skill_event.dart';
part 'skill_state.dart';

class SkillBloc extends Bloc<SkillEvent, SkillState> {
  final SessionEntity session;
  final SaveSessionUseCase saveSessionUseCase;

  SkillBloc({
    required this.session,
    required this.saveSessionUseCase,
  }) : super(const SkillInitial()) {
    on<LoadSkills>((event, emit) {
      emit(const SkillLoading());
      try {
        // Load skills from JSON or another source.
        List<SkillEntity>? skills = [];
        if (event.skills != null) {
          skills = event.skills;
        } else {
          skills = mapJsonToSkillEntities(
            defaultSkillsJson,
            session.id,
          ); // Mock data loader
        }

        emit(SkillLoaded(
          skills: skills!,
          selectedEquipment: EquipmentType.rodFloor,
          session: session,
        ));
      } catch (e) {
        emit(SkillError(e.toString()));
      }
    });

    on<IncrementReps>((event, emit) {
      if (state is SkillLoaded) {
        final currentState = state as SkillLoaded;
        final updatedSkills = currentState.skills.map((skill) {
          if (skill.id == event.skillId) {
            return skill.incrementRepsForEquipment(event.equipment);
          }
          return skill;
        }).toList();
        emit(currentState.copyWith(skills: updatedSkills));
      }
    });

    on<DecrementReps>((event, emit) {
      if (state is SkillLoaded) {
        final currentState = state as SkillLoaded;
        final updatedSkills = currentState.skills.map((skill) {
          if (skill.id == event.skillId) {
            return skill.decrementRepsForEquipment(event.equipment);
          }
          return skill;
        }).toList();
        emit(currentState.copyWith(skills: updatedSkills));
      }
    });

    on<UpdateReps>((event, emit) {
      if (state is SkillLoaded) {
        final currentState = state as SkillLoaded;
        final updatedSkills = currentState.skills.map((skill) {
          if (skill.id == event.skillId) {
            return skill.updateRepsForEquipment(event.equipment, event.newReps);
          }
          return skill;
        }).toList();
        emit(currentState.copyWith(skills: updatedSkills));
      }
    });

    on<ChangeEquipment>((event, emit) {
      if (state is SkillLoaded) {
        emit((state as SkillLoaded)
            .copyWith(selectedEquipment: event.newEquipment));
      }
    });

    on<SkillSaveSession>((event, emit) async {
      if (state is SkillLoaded) {
        final currentState = state as SkillLoaded;
        final session = currentState.session;
        final skills = currentState.skills;

        final result =
            await saveSessionUseCase.execute(session: session, skills: skills);

        result.fold(
          (failure) {
            emit(SkillSaveFailure(failure.message)); // Emit failure state
          },
          (success) {
            emit(SkillSaveSuccess(success.message)); // Emit success state
          },
        );
      }
    });
  }
}
