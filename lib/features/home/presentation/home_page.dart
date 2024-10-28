import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/features/monitoring/presentation/pages/monitor_page.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/presentation/pages/session_page.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final session = SessionEntity(
                  id: const Uuid().v4(),
                  athleteId: 'athlete123',
                  date: DateTime.now(),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => LayoutCubit(),
                            child: SessionPage(session: session),
                          )),
                );
              },
              child: const Text('Start Session'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
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
