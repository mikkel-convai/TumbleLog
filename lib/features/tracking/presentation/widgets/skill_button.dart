import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/skill_bloc/skill_bloc.dart';

class SkillButton extends StatefulWidget {
  final String skillId;
  final String name;
  final String symbol;
  final double difficulty;
  final int reps;
  final EquipmentType selectedEquipment;

  const SkillButton({
    super.key,
    required this.skillId,
    required this.name,
    required this.symbol,
    required this.difficulty,
    required this.reps,
    required this.selectedEquipment,
  });

  @override
  State<SkillButton> createState() => _SkillButtonState();
}

class _SkillButtonState extends State<SkillButton> {
  void _incrementCounter(BuildContext context) {
    // Dispatch the increment event to the SkillBloc
    context
        .read<SkillBloc>()
        .add(IncrementReps(widget.skillId, widget.selectedEquipment));
  }

  void _resetReps(BuildContext context) {
    // Dispatch the update event with reps set to 0 to the SkillBloc
    context
        .read<SkillBloc>()
        .add(UpdateReps(widget.skillId, widget.selectedEquipment, 0));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          String displayText;
          if (state.textDisplay == TextType.symbol) {
            displayText = widget.symbol;
          } else if (state.textDisplay == TextType.name) {
            displayText = widget.name;
          } else {
            displayText = widget.difficulty.toString();
          }

          return ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color?>(Colors.grey[200]),
            ),
            onLongPress: () => _resetReps(context),
            onPressed: () => _incrementCounter(context),
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
                    '${widget.reps}', // Display current reps
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
