import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/domain/entities/skill_entity.dart';

// TODO: UI test
// TODO: Figure out if i should use bloc instead of child object passed down
class SkillButton extends StatefulWidget {
  final SkillEntity skill;

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
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          String displayText;
          if (state.textDisplay == TextType.symbol) {
            displayText = widget.skill.symbol;
          } else if (state.textDisplay == TextType.name) {
            displayText = widget.skill.name;
          } else {
            displayText = widget.skill.difficulty.toString();
          }

          return ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color?>(Colors.grey[200]),
            ),
            onLongPress: () => resetReps(),
            onPressed: () => _incrementCounter(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    displayText, // Dynamic text based on the cubit's state
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    widget.skill.reps.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
