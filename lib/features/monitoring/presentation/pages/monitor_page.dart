import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_sessions.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_skills.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';
import 'package:tumblelog/features/monitoring/presentation/pages/monitor_session_page.dart';
import 'package:tumblelog/injection_container.dart';

class MonitorPage extends StatelessWidget {
  const MonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MonitorBloc(
        loadSessions: getIt<LoadSessionsUseCase>(),
        loadSkills: getIt<LoadSkillsUseCase>(),
      )..add(const MonitorLoadSessions()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Monitor Sessions'),
        ),
        body: BlocBuilder<MonitorBloc, MonitorState>(
          builder: (context, state) {
            if (state is MonitorLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MonitorStateLoaded) {
              return ListView.builder(
                itemCount: state.sessions.length,
                itemBuilder: (context, index) {
                  final session = state.sessions[index];
                  return Card(
                    margin: const EdgeInsets.all(10.0),
                    elevation: 3.0,
                    child: ListTile(
                      title: Text('Session ID: ${session.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Athlete: ${session.athleteName}'),
                          Text('Date: ${session.date}'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MonitorSessionPage(
                              session: session,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is MonitorError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            }

            return const SizedBox.shrink(); // Placeholder for other states
          },
        ),
      ),
    );
  }
}
