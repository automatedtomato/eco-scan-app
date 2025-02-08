import 'package:flutter/material.dart';
import 'core/navigation/app_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoScan',
      theme: ThemeData(
        primaryColor: const Color(0xFF008080),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF008080),
        ),
      ),
      home: const AppNavigator(),
    );
  }
}
