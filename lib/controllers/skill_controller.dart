import 'dart:convert';
import 'package:tumblelog/models/skill_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Function to save skills based on a date
Future<void> saveSkills(
    String date, SharedPreferences prefs, List<Skill> skills) async {
  // Convert skills list to JSON
  List<Map<String, dynamic>> skillsMap =
      skills.map((skill) => {'name': skill.name, 'reps': skill.reps}).toList();
  String skillsJson = jsonEncode(skillsMap);

  // Save the JSON string under the given date
  await prefs.setString(date, skillsJson);

  print('Skills saved in controller');
}

// Function to load skills based on a date
Future<List<Skill>> loadSkills(String date, SharedPreferences prefs) async {
  // Get the JSON string saved under the given date
  String? skillsJson = prefs.getString(date);

  // If there is no data, return an empty list
  if (skillsJson == null) {
    return [];
  }

  // Decode the JSON string back to a list of Skill objects
  List<dynamic> skillsMap = jsonDecode(skillsJson);
  print('Skills loaded in controller');
  return skillsMap
      .map((skillData) => Skill(
            name: skillData['name'],
            reps: skillData['reps'],
            symbol: skillData['symbol'],
          ))
      .toList();
}
