import 'package:flutter/material.dart';
import 'package:tumblelog/injection_container.dart';

// TODO: State -> CA BLoC

class AssignProgramPage extends StatefulWidget {
  const AssignProgramPage({super.key});

  @override
  State<AssignProgramPage> createState() => _AssignProgramPageState();
}

class _AssignProgramPageState extends State<AssignProgramPage> {
  List<dynamic> athletes = [];
  List<dynamic> programs = [];
  Map<String, String?> selectedPrograms = {};

  @override
  void initState() {
    super.initState();
    _fetchAthletes();
    _fetchPrograms();
  }

  Future<void> _fetchPrograms() async {
    try {
      final programRes =
          await supabaseClient.from('programs').select('id, name');

      if (programRes.isEmpty) {
        print('No programs found');
        setState(() {
          programs = [];
        });
      } else {
        setState(() {
          programs = programRes;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching programs: $e')),
        );
      }
    }
  }

  Future<void> _fetchAthletes() async {
    try {
      final response = await supabaseClient
          .from('users')
          .select('id, email')
          .eq('role', 'athlete');

      setState(() {
        athletes = response;
        // Initialize selected programs for each athlete
        for (var athlete in response) {
          selectedPrograms[athlete['id']] = null;
        }
      });
    } catch (error) {
      debugPrint('Error fetching athletes: $error');
    }
  }

  void _assignProgram(String athleteId, String? programId) {
    if (programId != null) {
      supabaseClient.from('athlete_programs').upsert(
        {
          'athlete_id': athleteId,
          'program_id': programId,
        },
        onConflict: 'athlete_id, program_id',
      ).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Program assigned successfully!')),
        );
      }).catchError((error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error assigning program: $error')),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assign Programs to Athletes')),
      body: athletes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: athletes.length,
              itemBuilder: (context, index) {
                final athlete = athletes[index];
                final athleteId = athlete['id'];
                final athleteName = athlete['email'] ?? 'No Email';

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
                          value: program['id'] as String,
                          child: Text(program['name'] ?? 'No Name'),
                        );
                      }).toList(),
                      onChanged: (String? newProgramId) {
                        setState(() {
                          selectedPrograms[athleteId] = newProgramId;
                        });
                        _assignProgram(athleteId, newProgramId);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
