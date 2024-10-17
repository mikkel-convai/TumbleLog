import 'package:flutter/material.dart';
import 'package:tumblelog/views/session_view_bar.dart';
import 'package:tumblelog/views/session_view_button.dart';
import 'package:tumblelog/widgets/bottom_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomBar(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: <Widget>[
          /// Session view with buttons
          const SessionViewButton(),

          // Session view with bars
          const SessionViewBar(),
        ][currentPageIndex],
      ),
    );
  }
}
