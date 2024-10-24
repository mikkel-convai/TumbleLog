part of 'skill_bloc.dart';

abstract class SkillEvent {}

class LoadSkills extends SkillEvent {
  final List<SkillEntity>? skills;

  LoadSkills({this.skills});
}

class IncrementReps extends SkillEvent {
  final String skillId;
  final EquipmentType equipment;

  IncrementReps(this.skillId, this.equipment);
}

class DecrementReps extends SkillEvent {
  final String skillId;
  final EquipmentType equipment;

  DecrementReps(this.skillId, this.equipment);
}

class UpdateReps extends SkillEvent {
  final String skillId;
  final EquipmentType equipment;
  final int newReps;

  UpdateReps(this.skillId, this.equipment, this.newReps);
}

class ChangeEquipment extends SkillEvent {
  final EquipmentType newEquipment;

  ChangeEquipment(this.newEquipment);
}
