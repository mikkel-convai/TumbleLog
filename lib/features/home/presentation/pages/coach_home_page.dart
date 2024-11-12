import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/core/widgets/auth_appbar.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';
import 'package:tumblelog/features/monitoring/presentation/pages/monitor_page.dart';
import 'package:tumblelog/features/monitoring/presentation/pages/monitor_week_page.dart';

class CoachHomePage extends StatefulWidget {
  const CoachHomePage({super.key});

  @override
  State<CoachHomePage> createState() => _CoachHomePageState();
}

class _CoachHomePageState extends State<CoachHomePage> {
  String? selectedAthleteId;
  String? selectedAthleteName;

  void _viewWeeklyMonitor(BuildContext context, String athleteId) {
    context
        .read<MonitorBloc>()
        .add(MonitorLoadSessionsForUser(athleteId: athleteId));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MonitorWeekPage(
          athleteId: athleteId,
        ),
      ),
    );
  }

  void _viewMonitor(BuildContext context, String athleteId) {
    context
        .read<MonitorBloc>()
        .add(MonitorLoadSessionsForUser(athleteId: athleteId));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MonitorPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(
        title: 'Coach Home',
      ),
      body: BlocBuilder<MonitorBloc, MonitorState>(
        builder: (context, state) {
          if (state is MonitorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MonitorAthletesLoaded ||
              state is MonitorStateLoaded) {
            // Use the athletes from the current state
            final athletes = state is MonitorAthletesLoaded
                ? state.athletes
                : (state as MonitorStateLoaded).athletes;

            if (athletes.isEmpty) {
              return const Center(
                child: Text(
                  'No athletes available.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: selectedAthleteId,
                    hint: const Text('Select Athlete'),
                    items: athletes.map((athlete) {
                      return DropdownMenuItem<String>(
                        value: athlete.id,
                        child: Text(athlete.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAthleteId = value;
                        selectedAthleteName = athletes
                            .firstWhere((athlete) => athlete.id == value)
                            .name;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: selectedAthleteId != null
                        ? () => _viewWeeklyMonitor(context, selectedAthleteId!)
                        : null,
                    child: const Text('Weekly view'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: selectedAthleteId != null
                        ? () => _viewMonitor(context, selectedAthleteId!)
                        : null,
                    child: const Text('View Monitor'),
                  ),
                ],
              ),
            );
          } else if (state is MonitorError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }

          return const Center(
            child: Text(
              'Loading athletes...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
