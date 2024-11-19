import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'skill_library_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SkillLibraryModel extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final double difficulty;
  final String? creatorId;
  final bool isDefault;

  const SkillLibraryModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.difficulty,
    this.creatorId,
    required this.isDefault,
  });

  // Factory method to create a SkillLibraryModel from JSON
  factory SkillLibraryModel.fromJson(Map<String, dynamic> json) =>
      _$SkillLibraryModelFromJson(json);

  // Method to convert a SkillLibraryModel to JSON
  Map<String, dynamic> toJson() => _$SkillLibraryModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        symbol,
        difficulty,
        isDefault,
        creatorId,
      ];
}
