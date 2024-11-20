import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tumblelog/core/models/skill_library_model.dart';

part 'program_model.g.dart';

// TODO: Write tests for this

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ProgramModel extends Equatable {
  final String id;
  final String name;
  final String? creatorId;

  @JsonKey(name: 'program_skills', fromJson: _extractSkillsFromProgramSkills)
  final List<SkillLibraryModel> skills;

  const ProgramModel({
    required this.id,
    required this.name,
    required this.creatorId,
    required this.skills,
  });

  /// Factory method to create a `ProgramModel` from JSON
  factory ProgramModel.fromJson(Map<String, dynamic> json) =>
      _$ProgramModelFromJson(json);

  /// Method to convert `ProgramModel` to JSON
  Map<String, dynamic> toJson() => _$ProgramModelToJson(this);

  /// Helper method to convert `program_skills` into a list of `SkillLibraryModel`
  static List<SkillLibraryModel> _extractSkillsFromProgramSkills(
      List<dynamic>? programSkills) {
    if (programSkills == null) return [];
    return programSkills
        .map((e) => SkillLibraryModel.fromJson(e['skill_library']))
        .toList();
  }

  /// Convert `ProgramModel` to a map for database saving
  Map<String, dynamic> toProgramsTableMap() {
    return {
      'id': id,
      'name': name,
      'creator_id': creatorId,
    };
  }

  /// Map skills to a list of `program_skills` entries
  List<Map<String, dynamic>> mapSkillsToProgramSkills(String programId) {
    return skills.map((skill) {
      return {
        'program_id': programId,
        'skill_id': skill.id,
      };
    }).toList();
  }

  @override
  List<Object?> get props => [id, name, creatorId, skills];
}
