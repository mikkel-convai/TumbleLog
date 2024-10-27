import 'dart:convert';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/models/session_model.dart';

List<SessionModel> parseSessionModelsFromString(String jsonString) {
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((json) {
    return SessionModel(
      id: json['id'],
      athleteId: json['athlete_id'],
      athleteName: json['athlete_name'],
      date: DateTime.parse(json['date']),
    );
  }).toList();
}

List<SessionEntity> parseSessionEntitiesFromString(String jsonString) {
  final sessionModels = parseSessionModelsFromString(jsonString);

  return sessionModels.map((session) {
    return SessionEntity(
        id: session.id,
        athleteId: session.athleteId,
        athleteName: session.athleteName,
        date: session.date);
  }).toList();
}
