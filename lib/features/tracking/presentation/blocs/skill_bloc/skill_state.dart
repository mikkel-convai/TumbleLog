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
  final SessionEntity session;

  const SkillLoaded({
    required this.skills,
    required this.selectedEquipment,
    required this.session,
  });

  @override
  List<Object?> get props => [skills, selectedEquipment, session];

  SkillLoaded copyWith({
    List<SkillEntity>? skills,
    EquipmentType? selectedEquipment,
    SessionEntity? session,
  }) {
    return SkillLoaded(
      skills: skills ?? this.skills,
      selectedEquipment: selectedEquipment ?? this.selectedEquipment,
      session: session ?? this.session,
    );
  }
}

final class SkillError extends SkillState {
  final String message;

  const SkillError(this.message);

  @override
  List<Object?> get props => [message];
}

final class SkillSaveFailure extends SkillState {
  final String message;
  const SkillSaveFailure(this.message);

  @override
  List<Object?> get props => [];
}

final class SkillSaveSuccess extends SkillState {
  final String message;
  const SkillSaveSuccess(this.message);

  @override
  List<Object?> get props => [];
}
