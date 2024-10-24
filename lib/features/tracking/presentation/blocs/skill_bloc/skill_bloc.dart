import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/utils/json_to_skill_entity.dart';
import 'package:tumblelog/features/tracking/domain/entities/skill_entity.dart';

part 'skill_event.dart';
part 'skill_state.dart';

class SkillBloc extends Bloc<SkillEvent, SkillState> {
  SkillBloc() : super(const SkillInitial()) {
    on<LoadSkills>((event, emit) {
      emit(const SkillLoading());
      try {
        // Load skills from JSON or another source.
        List<SkillEntity>? skills = [];
        if (event.skills != null) {
          skills = event.skills;
        } else {
          skills =
              mapJsonToSkillEntities(defaultSkillsJson); // Mock data loader
        }

        emit(SkillLoaded(
            skills: skills!, selectedEquipment: EquipmentType.rodFloor));
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
  }
}
