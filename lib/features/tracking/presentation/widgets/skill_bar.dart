import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/skill_bloc/skill_bloc.dart';

class SkillBar extends StatefulWidget {
  final String skillId;
  final String name;
  final String symbol;
  final double difficulty;
  final int reps;
  final EquipmentType selectedEquipment;

  const SkillBar({
    super.key,
    required this.skillId,
    required this.name,
    required this.symbol,
    required this.difficulty,
    required this.reps,
    required this.selectedEquipment,
  });

  @override
  SkillBarState createState() => SkillBarState();
}

class SkillBarState extends State<SkillBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = '${widget.reps}';
  }

  @override
  void didUpdateWidget(SkillBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reps != widget.reps) {
      _controller.text = '${widget.reps}';
    }
  }

  void _incrementCounter(BuildContext context) {
    context
        .read<SkillBloc>()
        .add(IncrementReps(widget.skillId, widget.selectedEquipment));
  }

  void _decrementCounter(BuildContext context) {
    context
        .read<SkillBloc>()
        .add(DecrementReps(widget.skillId, widget.selectedEquipment));
  }

  void _updateCounter(BuildContext context, String value) {
    final newValue = int.tryParse(value);
    if (newValue != null) {
      context
          .read<SkillBloc>()
          .add(UpdateReps(widget.skillId, widget.selectedEquipment, newValue));
    } else {
      // Revert to the current reps if input is invalid
      _controller.text = '${widget.reps}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        String displayText;
        if (state.textDisplay == TextType.symbol) {
          displayText = widget.symbol;
        } else if (state.textDisplay == TextType.name) {
          displayText = widget.name;
        } else {
          displayText = widget.difficulty.toString();
        }

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
                onPressed: () => _decrementCounter(context),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      displayText, // Dynamic text based on the cubit state
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
                        onSubmitted: (value) => _updateCounter(context, value),
                        onChanged: (value) => _updateCounter(context, value),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _incrementCounter(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
