import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SessionModel extends Equatable {
  final String id;
  final String athleteId;
  final String athleteName;
  final DateTime date;

  const SessionModel({
    required this.id,
    required this.athleteId,
    required this.date,
    this.athleteName = 'Grisha',
  });

  // Factory method to create a SessionModel from JSON
  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  // Method to convert a SessionModel to JSON
  Map<String, dynamic> toJson() => _$SessionModelToJson(this);

  @override
  List<Object?> get props => [id, athleteId, athleteName, date];
}
