import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/skill_bloc/skill_bloc.dart';
import 'package:tumblelog/features/tracking/presentation/pages/session_view_bar.dart';
import 'package:tumblelog/features/tracking/presentation/pages/session_view_button.dart';

class SessionPage extends StatelessWidget {
  final SessionEntity session;
  const SessionPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SkillBloc(session: session)..add(LoadSkills()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<LayoutCubit, LayoutState>(
            builder: (context, state) {
              if (state.layout == LayoutType.grid) {
                return const SessionViewButton(); // Show buttons layout
              } else {
                return const SessionViewBar(); // Show bars layout
              }
            },
          ),
        ),
      ),
    );
  }
}
