import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tumblelog/constants.dart';

part 'skill_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SkillModel extends Equatable {
  final String id;
  final String sessionId;
  final String name;
  final String symbol;
  final double difficulty;
  final Map<EquipmentType, int> equipmentReps;

  const SkillModel({
    required this.id,
    required this.sessionId,
    required this.name,
    required this.symbol,
    required this.difficulty,
    required this.equipmentReps,
  });

  // Factory method to create a SkillModel from JSON
  factory SkillModel.fromJson(Map<String, dynamic> json) =>
      _$SkillModelFromJson(json);

  // Method to convert a SkillModel to JSON
  Map<String, dynamic> toJson() => _$SkillModelToJson(this);

  @override
  List<Object?> get props =>
      [id, sessionId, name, symbol, difficulty, equipmentReps];
}
