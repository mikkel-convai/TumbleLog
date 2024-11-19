import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/core/entities/skill_library_entity.dart';
import 'package:tumblelog/features/home/presentation/pages/coach_home_page.dart';
import 'package:tumblelog/features/programming/presentation/widgets/program_name_input.dart';
import 'package:tumblelog/features/programming/presentation/widgets/skill_list.dart';
import 'package:tumblelog/features/programming/presentation/blocs/program_bloc/program_bloc.dart';

class CreateProgramViewLarge extends StatelessWidget {
  const CreateProgramViewLarge({super.key});

  void _addSkill(BuildContext context, SkillLibraryEntity skill) {
    context.read<ProgramBloc>().add(ProgramSkillAdded(skill: skill));
  }

  void _removeSkill(BuildContext context, SkillLibraryEntity skill) {
    context.read<ProgramBloc>().add(ProgramSkillRemoved(skill: skill));
  }

  void _saveProgram(BuildContext context) {
    final state = context.read<ProgramBloc>().state;

    if (state is ProgramCreateStateLoaded) {
      // Validate programName and selectedSkills
      if (state.program.name.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Program name cannot be empty!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (state.program.skills.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('At least one skill must be added!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Dispatch the save program event
      context.read<ProgramBloc>().add(SaveNewProgram());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Program'),
      ),
      body: BlocListener<ProgramBloc, ProgramState>(
        listener: (context, state) {
          if (state is ProgramError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ProgramSaved) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Program saved successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CoachHomePage(),
              ),
            );
          }
        },
        child: BlocBuilder<ProgramBloc, ProgramState>(
          builder: (context, state) {
            if (state is ProgramLoading ||
                state is ProgramSaved ||
                state is ProgramSaving) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProgramCreateStateLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const ProgramNameInput(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: SkillList(
                              skills: state.skillLibrary,
                              title: 'Skill Library',
                              actionIcon: Icons.add,
                              onSkillAction: (skill) =>
                                  _addSkill(context, skill),
                            ),
                          ),
                          const VerticalDivider(),
                          Expanded(
                            child: SkillList(
                              skills: state.program.skills,
                              title: 'Selected Skills',
                              actionIcon: Icons.remove,
                              onSkillAction: (skill) =>
                                  _removeSkill(context, skill),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: state is! ProgramSaving
                          ? () => _saveProgram(context)
                          : null, // Disable when saving
                      icon: const Icon(Icons.save),
                      label: const Text('Save Program'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
