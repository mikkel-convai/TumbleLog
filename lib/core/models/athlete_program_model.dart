import 'package:json_annotation/json_annotation.dart';

part 'athlete_program_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AthleteProgramModel {
  final String athleteId;
  final String programId;

  const AthleteProgramModel({
    required this.athleteId,
    required this.programId,
  });

  factory AthleteProgramModel.fromJson(Map<String, dynamic> json) =>
      _$AthleteProgramModelFromJson(json);

  Map<String, dynamic> toJson() => _$AthleteProgramModelToJson(this);
}
