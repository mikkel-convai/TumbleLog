import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
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
        child: ElevatedButton(
          onPressed: () {
            final session = SessionEntity(
              id: const Uuid().v4(),
              athleteId: 'athlete123',
              date: DateTime.now(),
            );

            // Wrapping page in provider for layout
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
      ),
    );
  }
}
