import 'package:json_annotation/json_annotation.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';

part 'skill_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SkillModel extends SkillEntity {
  SkillModel({
    super.id,
    required super.sessionId,
    required super.name,
    required super.symbol,
    required super.difficulty,
    super.equipmentReps,
  });

  // Factory method to create a SkillModel from JSON
  factory SkillModel.fromJson(Map<String, dynamic> json) =>
      _$SkillModelFromJson(json);

  // Method to convert a SkillModel to JSON
  Map<String, dynamic> toJson() => _$SkillModelToJson(this);
}
