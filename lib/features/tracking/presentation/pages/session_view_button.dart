import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/skill_bloc/skill_bloc.dart';
import 'package:tumblelog/features/tracking/presentation/widgets/equipment_dropdown.dart';
import 'package:tumblelog/features/tracking/presentation/widgets/session_app_bar.dart';
import 'package:tumblelog/features/tracking/presentation/widgets/skill_button.dart';

class SessionViewButton extends StatelessWidget {
  const SessionViewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SkillBloc()..add(LoadSkills()),
      child: Scaffold(
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
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: state.skills.length,
                      itemBuilder: (context, index) {
                        final skill = state.skills[index];
                        return SkillButton(
                          skillId: skill.id,
                          name: skill.name,
                          symbol: skill.symbol,
                          difficulty: skill.difficulty,
                          reps: skill
                              .getRepsForEquipment(state.selectedEquipment),
                          selectedEquipment: state.selectedEquipment,
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
      ),
    );
  }
}
