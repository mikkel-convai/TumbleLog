import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/auth/domain/usecases/get_current_session_usecase.dart';
import 'package:tumblelog/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:tumblelog/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:tumblelog/features/auth/domain/usecases/update_user_usecase.dart';
import 'package:tumblelog/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tumblelog/features/auth/presentation/pages/auth_navigator.dart';
import 'package:tumblelog/features/home/presentation/blocs/admin_bloc/admin_bloc.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_athletes.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_sessions.dart';
import 'package:tumblelog/features/monitoring/domain/usecases/load_skills.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';
import 'package:tumblelog/features/programming/presentation/blocs/assign_program_bloc/assign_program_bloc.dart';
import 'package:tumblelog/features/programming/presentation/blocs/program_bloc/program_bloc.dart';
import 'package:tumblelog/features/programming/presentation/blocs/view_program_bloc/view_program_bloc.dart';
import 'package:tumblelog/injection_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
            loadAthletes: getIt<LoadAthletesUseCase>(),
            loadSessions: getIt<LoadSessionsUseCase>(),
            loadSkills: getIt<LoadSkillsUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            getCurrentSession: getIt<GetCurrentSessionUseCase>(),
            getCurrentUser: getIt<GetCurrentUserUseCase>(),
            logOut: getIt<LogOutUseCase>(),
            updateUser: getIt<UpdateUserUseCase>(),
          )..add(CheckAuthStatus()),
        ),
        BlocProvider(create: (_) => getIt<ProgramBloc>()),
        BlocProvider(create: (_) => getIt<ViewProgramBloc>()),
        BlocProvider(create: (_) => getIt<AssignProgramBloc>()),
        BlocProvider(create: (_) => getIt<AdminBloc>()),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TubmleLog',
          home: AuthNavigator()),
    );
  }
}
