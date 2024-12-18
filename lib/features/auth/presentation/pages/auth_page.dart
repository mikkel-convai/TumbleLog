import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:tumblelog/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tumblelog/features/auth/presentation/pages/auth_navigator.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateHome(AuthResponse response) {
      context.read<AuthBloc>().add(CheckAuthStatus());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthNavigator()),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              // TODO: Setup redirect url
              // Reset password us currently shown, but nothing happens
              child: SupaEmailAuth(
                redirectTo: kIsWeb ? null : 'SETUP AUTH CALLBACK FOR APP',
                onSignInComplete: navigateHome,
                onSignUpComplete: navigateHome,
                metadataFields: [
                  BooleanMetaDataField(
                    label: 'Coach',
                    key: 'coach',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
