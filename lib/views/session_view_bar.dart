import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/controllers/skill_controller.dart';
import 'package:tumblelog/models/skill_model.dart';
import 'package:tumblelog/widgets/session_app_bar.dart';
import 'package:tumblelog/widgets/skill_bar.dart';
import 'package:intl/intl.dart';

class SessionViewBar extends StatefulWidget {
  const SessionViewBar({super.key});

  @override
  State<SessionViewBar> createState() => _SessionViewBarState();
}

class _SessionViewBarState extends State<SessionViewBar> {
  late SharedPreferences pref;
  List<Skill> skills = defaultSkills;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPref();
  }

  Future<void> _initPref() async {
    pref = await SharedPreferences.getInstance();
    _loadSkillsForToday();
    setState(() {
      isLoading = false; // Set loading to false after initialization
    });
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

  String getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('MMMM d, yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator()); // Show loading indicator
    }

    return Scaffold(
        appBar: SessionAppBar(pref: pref, skills: skills),
        body: ListView.builder(
          padding: const EdgeInsets.all(20.0),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: SkillBar(skill: skills[index]),
            );
          },
        ));
  }
}
