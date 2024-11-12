import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/widgets/auth_appbar.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';
import 'package:tumblelog/features/monitoring/presentation/pages/monitor_page.dart';
import 'package:tumblelog/features/monitoring/presentation/pages/monitor_week_page.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/presentation/pages/session_page.dart';
import 'package:uuid/uuid.dart';

class CoachHomePage extends StatefulWidget {
  const CoachHomePage({super.key});

  @override
  State<CoachHomePage> createState() => _CoachHomePageState();
}

class _CoachHomePageState extends State<CoachHomePage> {
  final List<Map<String, String>> athletes = [
    {'id': 'athlete123', 'name': 'Grisha'},
    {'id': 'athlete124', 'name': 'Bree'},
    {'id': 'athlete125', 'name': 'Alexsa'},
  ];

  String? selectedAthleteId;
  String? selectedAthleteName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(
        title: 'Coach Home',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedAthleteId,
              hint: const Text('Select Athlete'),
              items: athletes.map((athlete) {
                return DropdownMenuItem<String>(
                  value: athlete['id'],
                  child: Text(athlete['name']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAthleteId = value;
                  selectedAthleteName = athletes
                      .firstWhere((athlete) => athlete['id'] == value)['name'];
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedAthleteId != null
                  ? () {
                      final session = SessionEntity(
                        id: const Uuid().v4(),
                        athleteId: selectedAthleteId!,
                        athleteName: selectedAthleteName!,
                        date: DateTime.now(),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => LayoutCubit(),
                            child: SessionPage(session: session),
                          ),
                        ),
                      );
                    }
                  : null, // Disable the button if no athlete is selected
              child: const Text('Start Session'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedAthleteId != null
                  ? () {
                      context
                          .read<MonitorBloc>()
                          .add(const MonitorLoadAllSessions());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MonitorWeekPage(
                            athleteId: selectedAthleteId!,
                          ),
                        ),
                      );
                    }
                  : null,
              child: const Text('Weekly view'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<MonitorBloc>().add(const MonitorLoadAllSessions());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonitorPage(),
                  ),
                );
              },
              child: const Text('View Monitor'),
            ),
          ],
        ),
      ),
    );
  }
}
