import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/home/presentation/home_page.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_sessions.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_skills.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';
import 'package:tumblelog/injection_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: dotenv.env['DB_URL']!,
    anonKey: dotenv.env['DB_KEY']!,
  );

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MonitorBloc(
            loadSessions: getIt<LoadSessionsUseCase>(),
            loadSkills: getIt<LoadSkillsUseCase>(),
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TubmleLog',
        home: HomePage(),
      ),
    );
  }
}
