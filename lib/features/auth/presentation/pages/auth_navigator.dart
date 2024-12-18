import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tumblelog/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tumblelog/features/auth/presentation/pages/auth_page.dart';
import 'package:tumblelog/features/home/presentation/blocs/admin_bloc/admin_bloc.dart';
import 'package:tumblelog/features/home/presentation/pages/admin_home_page.dart';
import 'package:tumblelog/features/home/presentation/pages/athlete_home_page.dart';
import 'package:tumblelog/features/home/presentation/pages/coach_home_page.dart';
import 'package:tumblelog/features/home/presentation/pages/home_page.dart';
import 'package:tumblelog/features/monitoring/presentation/blocs/monitor_bloc/monitor_bloc.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AppAuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          FlutterNativeSplash.remove();
          final userRole = state.user.role;
          final userClub = state.user.clubId;
          if (userRole == 'athlete') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AthleteHomePage()),
            );
          } else if (userRole == 'coach') {
            context.read<MonitorBloc>().add(MonitorLoadAthletes(userClub));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CoachHomePage()),
            );
          } else if (userRole == 'admin') {
            context.read<AdminBloc>().add(FetchClubsAndUsersEvent());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AdminHomePage()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }
        } else if (state is AuthUnauthenticated) {
          FlutterNativeSplash.remove();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AuthPage()),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
