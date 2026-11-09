import 'package:flutter/material.dart';
import 'package:filacero/core/app_strings.dart';
import 'package:filacero/screens/map_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.local_gas_station, size: 96),
              const SizedBox(height: 16),
              Text(
                AppStrings.appName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                AppStrings.welcomeSubtitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const MapScreen()),
                  );
                },
                child: const Text(AppStrings.enterWithoutAccount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
