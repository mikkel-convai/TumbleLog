import 'dart:convert';
import 'package:tumblelog/core/models/session_model.dart';

List<SessionModel> parseSessionsFromString(String jsonString) {
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
