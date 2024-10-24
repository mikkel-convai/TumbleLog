import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/skill_bloc/skill_bloc.dart';
import 'package:tumblelog/features/tracking/presentation/widgets/equipment_dropdown.dart';
import 'package:tumblelog/features/tracking/presentation/widgets/session_app_bar.dart';
import 'package:tumblelog/features/tracking/presentation/widgets/skill_bar.dart';

class SessionViewBar extends StatelessWidget {
  const SessionViewBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SessionAppBar(),
      body: BlocBuilder<SkillBloc, SkillState>(
        builder: (context, state) {
          if (state is SkillLoading) {
            return const CircularProgressIndicator();
          } else if (state is SkillLoaded) {
            return Column(
              children: [
                EquipmentDropdown(
                  initialEquipment: state.selectedEquipment,
                  onEquipmentChanged: (newEquipment) {
                    context
                        .read<SkillBloc>()
                        .add(ChangeEquipment(newEquipment));
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20.0),
                    itemCount: state.skills.length,
                    itemBuilder: (context, index) {
                      final skill = state.skills[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: SkillBar(
                          skillId: skill.id,
                          name: skill.name,
                          symbol: skill.symbol,
                          difficulty: skill.difficulty,
                          reps: skill
                              .getRepsForEquipment(state.selectedEquipment),
                          selectedEquipment: state.selectedEquipment,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is SkillError) {
            return Text('Error: ${state.message}');
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
