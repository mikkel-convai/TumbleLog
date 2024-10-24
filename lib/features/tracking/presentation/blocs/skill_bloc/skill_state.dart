part of 'skill_bloc.dart';

sealed class SkillState extends Equatable {
  const SkillState();

  @override
  List<Object?> get props => [];
}

final class SkillInitial extends SkillState {
  const SkillInitial();

  @override
  List<Object?> get props => [];
}

final class SkillLoading extends SkillState {
  const SkillLoading();

  @override
  List<Object?> get props => [];
}

final class SkillLoaded extends SkillState {
  final List<SkillEntity> skills;
  final EquipmentType selectedEquipment;

  const SkillLoaded({
    required this.skills,
    required this.selectedEquipment,
  });

  @override
  List<Object?> get props => [skills, selectedEquipment];

  SkillLoaded copyWith({
    List<SkillEntity>? skills,
    EquipmentType? selectedEquipment,
  }) {
    return SkillLoaded(
      skills: skills ?? this.skills,
      selectedEquipment: selectedEquipment ?? this.selectedEquipment,
    );
  }
}

final class SkillError extends SkillState {
  final String message;

  const SkillError(this.message);

  @override
  List<Object?> get props => [message];
}
