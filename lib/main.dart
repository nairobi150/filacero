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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B00),
          brightness: Brightness.light,
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
