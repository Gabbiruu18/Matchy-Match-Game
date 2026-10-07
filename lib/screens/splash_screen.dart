import 'package:flutter/material.dart';
import 'menu_screen.dart';

// Equivalent of SplashActivity.kt
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MenuScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Replace with whatever activity_splash.xml showed (logo, app name, etc.)
    return const Scaffold(
      body: Center(
        child: Text(
          'Matching Game',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
