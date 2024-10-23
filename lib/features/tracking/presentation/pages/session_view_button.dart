import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/controllers/skill_controller.dart';
import 'package:tumblelog/features/tracking/domain/entities/skill_entity.dart';
import 'package:tumblelog/features/tracking/presentation/widgets/equipment_dropdown.dart';
import 'package:tumblelog/features/tracking/presentation/widgets/session_app_bar.dart';
import 'package:tumblelog/features/tracking/presentation/widgets/skill_button.dart';

//TODO: UI test
class SessionViewButton extends StatefulWidget {
  const SessionViewButton({super.key});

  @override
  State<SessionViewButton> createState() => _SessionViewButtonState();
}

class _SessionViewButtonState extends State<SessionViewButton> {
  late SharedPreferences pref;
  List<SkillEntity> skills = defaultSkills;
  bool isLoading = true;
  EquipmentType selectedEquipment = EquipmentType.rodFloor; // Default equipment

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

  // TODO: Replace with databases
  Future<void> _loadSkillsForToday() async {
    String date = getCurrentDate();
    List<SkillEntity> loadedSkills = await loadSkills(date, pref);

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

  void _onEquipmentChanged(EquipmentType newEquipment) {
    setState(() {
      selectedEquipment = newEquipment;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator()); // Show loading indicator
    }

    return Scaffold(
      appBar: SessionAppBar(
        pref: pref,
        skills: skills,
      ),
      body: Column(
        children: [
          EquipmentDropdown(
            initialEquipment: selectedEquipment,
            onEquipmentChanged: _onEquipmentChanged,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                return SkillButton(skill: skills[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
