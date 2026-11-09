import 'package:flutter/material.dart';
import 'package:filacero/core/app_strings.dart';
import 'package:filacero/screens/welcome_screen.dart';

void main() => runApp(const FilaCeroApp());

class FilaCeroApp extends StatelessWidget {
  const FilaCeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true),
      home: const WelcomeScreen(),
    );
  }
}
