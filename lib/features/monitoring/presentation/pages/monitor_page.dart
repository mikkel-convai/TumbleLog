import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';
import 'package:tumblelog/features/monitoring/presentation/pages/monitor_session_page.dart';

class MonitorPage extends StatelessWidget {
  const MonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitor Sessions'),
      ),
      body: BlocBuilder<MonitorBloc, MonitorState>(
        builder: (context, state) {
          if (state is MonitorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MonitorStateLoaded) {
            if (state.sessions.isEmpty) {
              return const Center(
                child: Text(
                  'No sessions available.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.sessions.length,
              itemBuilder: (context, index) {
                final session = state.sessions[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  elevation: 3.0,
                  child: ListTile(
                    title: Text('Athlete: ${session.athleteName}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${session.date}'),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        const Text('Session DD:'),
                        Text(
                          session.totalDd.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      context
                          .read<MonitorBloc>()
                          .add(MonitorLoadSkills(sessionId: session.id));
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
    );
  }
}
