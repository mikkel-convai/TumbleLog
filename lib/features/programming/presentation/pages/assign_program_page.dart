import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tumblelog/features/programming/presentation/blocs/assign_program_bloc/assign_program_bloc.dart';

// TODO: Provide feedback on assigning user
// TODO: Make existing assignments visible

class AssignProgramPage extends StatefulWidget {
  const AssignProgramPage({super.key});

  @override
  State<AssignProgramPage> createState() => _AssignProgramPageState();
}

class _AssignProgramPageState extends State<AssignProgramPage> {
  Map<String, String?> selectedPrograms = {};

  @override
  void initState() {
    super.initState();
    _initAssignData();
  }

  void _initAssignData() {
    final userState = context.read<AuthBloc>().state;
    if (userState is AuthAuthenticated) {
      final String? clubId = userState.user.clubId;
      context.read<AssignProgramBloc>().add(LoadAssignProgramData(clubId));
    }
  }

  void _assignProgram(
      BuildContext context, String athleteId, String? programId) {
    if (programId != null) {
      context.read<AssignProgramBloc>().add(AssignProgramToAthlete(
            athleteId: athleteId,
            programId: programId,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assign Programs to Athletes')),
      body: BlocBuilder<AssignProgramBloc, AssignProgramState>(
        builder: (context, state) {
          if (state is AssignProgramLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AssignProgramLoaded) {
            final athletes = state.athletes;
            final programs = state.programs;

            return ListView.builder(
              itemCount: athletes.length,
              itemBuilder: (context, index) {
                final athlete = athletes[index];
                final athleteId = athlete.id;
                final athleteName = athlete.email;

                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      athleteName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: DropdownButton<String>(
                      value: selectedPrograms[athleteId],
                      hint: const Text('Assign Program'),
                      items: programs.map<DropdownMenuItem<String>>((program) {
                        return DropdownMenuItem<String>(
                          value: program.id,
                          child: Text(program.name),
                        );
                      }).toList(),
                      onChanged: (String? newProgramId) {
                        setState(() {
                          selectedPrograms[athleteId] = newProgramId;
                        });
                        _assignProgram(context, athleteId, newProgramId);
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is AssignProgramError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}
