import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/core/entities/session_entity.dart';
import 'package:tumblelog/core/entities/skill_entity.dart';
import 'package:tumblelog/features/tracking/domain/usecases/calculate_dd_usecase.dart';
import 'package:tumblelog/features/tracking/domain/usecases/save_session_usecase.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/skill_bloc/skill_bloc.dart';
import 'package:tumblelog/features/tracking/presentation/pages/session_view_bar.dart';
import 'package:tumblelog/features/tracking/presentation/pages/session_view_button.dart';
import 'package:tumblelog/features/tracking/presentation/widgets/session_app_bar.dart';
import 'package:tumblelog/injection_container.dart';

class SessionPage extends StatelessWidget {
  final SessionEntity session;
  final List<SkillEntity>? skills;
  const SessionPage({super.key, required this.session, this.skills});

  @override
  Widget build(BuildContext context) {
    // Keeping BlocProvider here to add the right session
    return BlocProvider(
      create: (context) => SkillBloc(
        session: session,
        saveSessionUseCase: getIt<SaveSessionUseCase>(),
        calcDdUseCase: getIt<CalculateDdUseCase>(),
      )..add(LoadSkills(skills: skills)),
      child: Scaffold(
        appBar: const SessionAppBar(),
        body: SafeArea(
          child: BlocListener<SkillBloc, SkillState>(
            listener: (context, state) {
              if (state is SkillSaveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).pop();
              } else if (state is SkillSaveFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
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
      ),
    );
  }
}
