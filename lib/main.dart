import 'package:flutter/material.dart';
import 'package:tumblelog/features/home/presentation/home_page.dart';
import 'package:tumblelog/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TubmleLog',
      home: HomePage(),
    );
  }
}
