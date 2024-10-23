import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/presentation/pages/session_view_bar.dart';
import 'package:tumblelog/features/tracking/presentation/pages/session_view_button.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
