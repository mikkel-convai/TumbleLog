import 'package:equatable/equatable.dart';
import 'package:tumblelog/core/entities/skill_library_entity.dart';

class ProgramEntity extends Equatable {
  final String id;
  final String name;
  final String? creatorId;
  final List<SkillLibraryEntity> skills;

  const ProgramEntity({
    required this.id,
    required this.name,
    this.creatorId,
    required this.skills,
  });

  @override
  List<Object?> get props => [id, name, creatorId, skills];

  ProgramEntity copyWith({
    String? id,
    String? name,
    List<SkillLibraryEntity>? skills,
    String? creatorId,
  }) {
    return ProgramEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      skills: skills ?? this.skills,
      creatorId: creatorId ?? this.creatorId,
    );
  }
}
