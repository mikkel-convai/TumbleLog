import 'package:json_annotation/json_annotation.dart';
import 'package:tumblelog/core/entities/session_entity.dart';

part 'session_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SessionModel extends SessionEntity {
  const SessionModel({
    required super.id,
    required super.athleteId,
    required super.date,
    super.athleteName,
  });

  // Factory method to create a SessionModel from JSON
  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  // Method to convert a SessionModel to JSON
  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
