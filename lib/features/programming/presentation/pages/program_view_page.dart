import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/core/entities/program_entity.dart';
import 'package:tumblelog/core/entities/skill_library_entity.dart';
import 'package:tumblelog/features/programming/presentation/blocs/view_program_bloc/view_program_bloc.dart';

class ProgramView extends StatefulWidget {
  const ProgramView({super.key});

  @override
  State<ProgramView> createState() => _ProgramViewState();
}

class _ProgramViewState extends State<ProgramView> {
  String? selectedProgramId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Program View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ViewProgramBloc, ViewProgramState>(
          builder: (context, state) {
            if (state is ViewProgramLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ViewProgramError) {
              return Center(child: Text(state.message));
            } else if (state is ViewProgramLoaded) {
              final programs = state.programs;

              return Column(
                children: [
                  // Dropdown to select a program
                  DropdownButton<String>(
                    value: selectedProgramId,
                    hint: const Text('Select a program'),
                    items: programs.map((program) {
                      return DropdownMenuItem<String>(
                        value: program.id,
                        child: Text(program.name),
                      );
                    }).toList(),
                    onChanged: (programId) {
                      setState(() {
                        selectedProgramId = programId;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // List of skills for the selected program
                  Expanded(
                    child: selectedProgramId == null
                        ? const Center(child: Text('No program selected'))
                        : _buildSkillsList(
                            programs
                                .firstWhere(
                                  (program) => program.id == selectedProgramId!,
                                  orElse: () => const ProgramEntity(
                                    id: '',
                                    name: '',
                                    skills: [],
                                  ),
                                )
                                .skills,
                          ),
                  ),
                ],
              );
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }

  Widget _buildSkillsList(List<SkillLibraryEntity> skills) {
    if (skills.isEmpty) {
      return const Center(child: Text('No skills to display'));
    }

    return ListView.builder(
      itemCount: skills.length,
      itemBuilder: (context, index) {
        final skill = skills[index];
        return ListTile(
          leading: Text(skill.symbol),
          title: Text(skill.name),
          subtitle: Text('Difficulty: ${skill.difficulty}'),
        );
      },
    );
  }
}
