import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/controllers/skill_controller.dart';
import 'package:tumblelog/models/skill_model.dart';
import 'package:tumblelog/widgets/skill_button.dart';

class SessionViewButton extends StatefulWidget {
  const SessionViewButton({super.key});

  @override
  State<SessionViewButton> createState() => _SessionViewButtonState();
}

class _SessionViewButtonState extends State<SessionViewButton> {
  late final SharedPreferences pref;
  List<Skill> skills = defaultSkills;

  @override
  void initState() {
    super.initState();
    _initPref();
  }

  Future<void> _initPref() async {
    pref = await SharedPreferences.getInstance();
    _loadSkillsForToday();
  }

  Future<void> _loadSkillsForToday() async {
    String date = getCurrentDate();
    List<Skill> loadedSkills = await loadSkills(date, pref);

    // If skills exist for today, update the state
    if (loadedSkills.isNotEmpty) {
      setState(() {
        skills = loadedSkills;
      });
    } else {
      setState(() {
        skills = defaultSkills;
      });
    }
  }

  Future<void> _saveSkillsForToday() async {
    String date = getCurrentDate();
    await saveSkills(date, pref, skills);
  }

  String getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('MMMM d, yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getCurrentDate()),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSkillsForToday,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: skills.length,
        itemBuilder: (context, index) {
          return SkillButton(skill: skills[index]);
        },
      ),
    );
  }
}
