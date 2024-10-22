import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';
import 'package:tumblelog/features/tracking/presentation/pages/session_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TubmleLog',
      home: BlocProvider(
        create: (_) => LayoutCubit(),
        child: const SessionPage(),
      ),
    );
  }
}
