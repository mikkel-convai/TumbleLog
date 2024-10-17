import 'package:flutter/material.dart';
import 'package:tumblelog/models/skill_model.dart';

class SkillButton extends StatefulWidget {
  final Skill skill;

  const SkillButton({super.key, required this.skill});

  @override
  State<SkillButton> createState() => _SkillButtonState();
}

class _SkillButtonState extends State<SkillButton> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = '${widget.skill.reps}';
  }

  void _incrementCounter() {
    setState(() {
      widget.skill.reps++;
      _controller.text = '${widget.skill.reps}';
    });
  }

  void resetReps() {
    setState(() {
      widget.skill.reps = 0;
      _controller.text = '${widget.skill.reps}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color?>(Colors.grey[200]),
        ),
        onLongPress: () => resetReps(),
        onPressed: () => _incrementCounter(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.skill.name,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                widget.skill.reps.toString(),
                style: const TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
