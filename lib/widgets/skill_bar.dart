import 'package:flutter/material.dart';
import 'package:tumblelog/models/skill_model.dart';

class SkillBar extends StatefulWidget {
  final Skill skill;

  const SkillBar({super.key, required this.skill});

  @override
  SkillBarState createState() => SkillBarState();
}

class SkillBarState extends State<SkillBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = '${widget.skill.reps}';
  }

  @override
  void didUpdateWidget(SkillBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.skill.reps != widget.skill.reps) {
      _controller.text = '${widget.skill.reps}';
    }
  }

  void _incrementCounter() {
    setState(() {
      widget.skill.reps++;
      _controller.text = '${widget.skill.reps}';
    });
  }

  void _decrementCounter() {
    setState(() {
      if (widget.skill.reps > 0) {
        widget.skill.reps--;
        _controller.text = '${widget.skill.reps}';
      }
    });
  }

  void _updateCounter(String value) {
    setState(() {
      int? newValue = int.tryParse(value);
      if (newValue != null) {
        widget.skill.reps = newValue;
      } else {
        _controller.text = '${widget.skill.reps}'; // Revert if invalid input
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _decrementCounter,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.skill.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onSubmitted: _updateCounter,
                    onChanged: _updateCounter,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _incrementCounter,
          ),
        ],
      ),
    );
  }
}
