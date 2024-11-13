import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/widgets/auth_appbar.dart';
import 'package:tumblelog/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';
import 'package:tumblelog/features/monitoring/presentation/pages/monitor_page.dart';
import 'package:tumblelog/features/monitoring/presentation/pages/monitor_week_page.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/presentation/pages/session_page.dart';
import 'package:tumblelog/injection_container.dart';
import 'package:uuid/uuid.dart';

class AthleteHomePage extends StatefulWidget {
  const AthleteHomePage({super.key});

  @override
  State<AthleteHomePage> createState() => _AthleteHomePageState();
}

class _AthleteHomePageState extends State<AthleteHomePage> {
  final TextEditingController _nameController = TextEditingController();

  void _startSession(
      BuildContext context, String athleteId, String athleteName) {
    final session = SessionEntity(
      id: const Uuid().v4(),
      athleteId: athleteId,
      athleteName: athleteName,
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

  // TODO: Make Clean Architecture
  Future<void> _updateUserName(
      BuildContext context, String newName, String userId) async {
    if (newName.isEmpty) return;

    try {
      final updatedUser = await supabaseClient
          .from('users')
          .update({'name': newName})
          .eq('id', userId)
          .select();

      if (updatedUser.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name updated successfully')),
        );

        // Update the AuthBloc state if necessary
        context.read<AuthBloc>().add(CheckAuthStatus());
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update name')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      final currentUser = authState.user;
      final athleteId = currentUser.id;
      final athleteName = currentUser.name;

      return Scaffold(
        appBar: const AuthAppBar(
          title: 'Athlete Home',
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              athleteName == "NoName"
                  ? Center(
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.all(16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Please enter your name:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Name',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  _updateUserName(
                                    context,
                                    _nameController.text.trim(),
                                    athleteId,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                ),
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _startSession(context, athleteId, athleteName),
                child: const Text('Start Session'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _viewWeeklyMonitor(context, athleteId),
                child: const Text('Weekly view'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _viewMonitor(context, athleteId),
                child: const Text('All Sessions'),
              ),
            ],
          ),
        ),
      );
    }

    // Show a loading indicator while the authentication state is unknown
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
