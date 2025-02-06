import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/app_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EPSILON',
      theme: AppTheme.light,
      home: const AppNavigator(),
    );
  }
}
