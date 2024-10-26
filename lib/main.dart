import 'package:flutter/material.dart';
import 'package:tumblelog/features/home/presentation/home_page.dart';
import 'package:tumblelog/injection_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Hide keys
  await Supabase.initialize(
    url: 'https://iszxmsufbsisxdelhpvb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlzenhtc3VmYnNpc3hkZWxocHZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjk5MzM0MDksImV4cCI6MjA0NTUwOTQwOX0.VhjVvMTZEQ06x-ODMEjaCiU0VQo0xxPdLseHoXI-Myg',
  );

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
