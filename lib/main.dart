/// The entry point for the Home Service App.
/// 
/// This file sets up the main [MaterialApp] and the application theme.
/// Last Updated: 2025-12-20
/// Version: 1.0.1+1 (Minor UI & Doc Polish)
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/main_wrapper.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Service App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainWrapper(),
    );
  }
}
