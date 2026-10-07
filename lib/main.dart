import 'package:flutter/material.dart';
import 'package:matchymatch/components/theme.dart';
import 'package:matchymatch/screens/splash_screen.dart';

void main() {
  runApp(const MatchingGameApp());
}

class MatchingGameApp extends StatelessWidget {
  const MatchingGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matching Game',
      debugShowCheckedModeBanner: false,
      theme: matchingGameTheme(dark: false),
      darkTheme: matchingGameTheme(dark: true),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
