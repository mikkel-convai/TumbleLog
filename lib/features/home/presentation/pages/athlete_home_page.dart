import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/widgets/auth_appbar.dart';
import 'package:tumblelog/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tumblelog/features/home/presentation/widgets/naming_view.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';
import 'package:tumblelog/features/monitoring/presentation/pages/monitor_page.dart';
import 'package:tumblelog/features/monitoring/presentation/pages/monitor_week_page.dart';
import 'package:tumblelog/features/programming/presentation/pages/program_view_page.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/presentation/pages/session_page.dart';
import 'package:uuid/uuid.dart';

class AthleteHomePage extends StatelessWidget {
  const AthleteHomePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AppAuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Name updated successfully')),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      child: Builder(
        builder: (context) {
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
                        ? NamingView(athleteId: athleteId)
                        : Text(
                            'Welcome back, $athleteName!',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () =>
                          _startSession(context, athleteId, athleteName),
                      child: const Text('Start Session'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProgramView(),
                        ),
                      ),
                      child: const Text('See programs'),
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

          return const Scaffold(
            body: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Loading authentication')
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
