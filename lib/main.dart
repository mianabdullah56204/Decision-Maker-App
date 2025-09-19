import 'package:flutter/material.dart';
import 'package:decision_maker/app_theme.dart';
import 'package:decision_maker/decision_home.dart';

void main() => runApp(DecisionMakerApp());

class DecisionMakerApp extends StatelessWidget {
  const DecisionMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = Colors.teal;
    return MaterialApp(
      title: 'Decision Maker',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.light(seed),
      darkTheme: AppTheme.dark(seed),
      home: DecisionHome(),
    );
  }
}
