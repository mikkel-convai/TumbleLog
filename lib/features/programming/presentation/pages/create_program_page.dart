import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:tumblelog/features/programming/presentation/blocs/program_bloc/program_bloc.dart';
import 'package:tumblelog/features/programming/presentation/pages/create_program_large_view.dart';
import 'package:tumblelog/features/programming/presentation/pages/create_program_small_view.dart';

class CreateProgramPage extends StatelessWidget {
  const CreateProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const desktopBreakpoint = 800;

    // Access the AuthBloc to get the user's ID
    final authState = context.read<AuthBloc>().state;

    // Access the ProgramBloc
    final bloc = context.read<ProgramBloc>();

    // Dispatch ProgramCreationInit only if the state is not already loaded
    if (bloc.state is! ProgramCreateStateLoaded) {
      if (authState is AuthAuthenticated) {
        bloc.add(ProgramCreationInit(creatorId: authState.user.id));
      } else {
        // Handle unauthenticated case if necessary
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not authenticated.')),
        );
        bloc.add(const ProgramCreationInit());
      }
    }

    return BlocListener<ProgramBloc, ProgramState>(
      listener: (context, state) {
        if (state is ProgramSaved) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: screenWidth > desktopBreakpoint
            ? const CreateProgramViewLarge()
            : const CreateProgramViewSmall(),
      ),
    );
  }
}
