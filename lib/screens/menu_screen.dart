import 'package:flutter/material.dart';
import 'dart:io' show exit;
import 'game_screen.dart';

// Equivalent of MenuActivity.kt
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_match.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Matching Game',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Color(
                  0xFF910015)),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const GameScreen()),
                );
              },
              child: const Text('Start Game'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Equivalent of finishAffinity() — closes the app.
                exit(0);
              },
              child: const Text('Exit'),
            ),
          ],
            ),
          ),
        ],
      ),
    );
  }
}
