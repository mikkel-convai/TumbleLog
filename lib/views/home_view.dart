import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/tracking/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/views/session_view_bar.dart';
import 'package:tumblelog/views/session_view_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
