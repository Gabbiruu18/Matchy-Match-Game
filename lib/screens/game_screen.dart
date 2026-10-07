import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

// Equivalent of MainActivity.kt

const int totalPairs = 8;
const int totalTimeSeconds = 60; // totalTime = 60000L in Kotlin

// Equivalent of imageMap: card value -> asset path.
// Put the matching image files under assets/images/ and declare them in pubspec.yaml.
const Map<int, String> imageMap = {
  1: 'assets/images/sol.png',
  2: 'assets/images/gab.png',
  3: 'assets/images/key.png',
  4: 'assets/images/elmo.png',
  5: 'assets/images/drix.png',
  6: 'assets/images/ren.png',
  7: 'assets/images/kalf.png',
  8: 'assets/images/kuys.png',
};

const String cardBackAsset = 'assets/images/background_match.jpg';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _CardState {
  final int value;
  bool isFaceUp = false;
  bool isClickable = true;

  _CardState(this.value);
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late List<_CardState> cards;
  late List<AnimationController> flipControllers;

  int? firstSelectedIndex;
  bool isBusy = false;
  int matchedPairs = 0;

  Timer? _timer;
  int secondsLeft = totalTimeSeconds;

  @override
  void initState() {
    super.initState();
    _setupGameBoard();
  }

  void _setupGameBoard() {
    final values = [for (var i = 1; i <= totalPairs; i++) ...[i, i]];
    values.shuffle(Random());

    cards = values.map((v) => _CardState(v)).toList();
    flipControllers = List.generate(
      cards.length,
          (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300), // flipOut(150) + flipIn(150)
      ),
    );

    matchedPairs = 0;
    firstSelectedIndex = null;
    isBusy = false;

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    secondsLeft = totalTimeSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        secondsLeft--;
      });
      if (secondsLeft <= 0) {
        t.cancel();
        _showLoseDialog();
      }
    });
  }

  Future<void> _onCardTapped(int index) async {
    if (isBusy) return;
    final card = cards[index];
    if (!card.isClickable || card.isFaceUp) return;

    // Flip this card face up (animate then reveal, like flipCard in Kotlin).
    await _flipCard(index, faceUp: true);
    card.isClickable = false;

    if (firstSelectedIndex == null) {
      setState(() => firstSelectedIndex = index);
    } else {
      setState(() => isBusy = true);
      final firstIndex = firstSelectedIndex!;
      final firstCard = cards[firstIndex];

      if (firstCard.value == card.value) {
        // Match found
        setState(() {
          matchedPairs++;
          firstSelectedIndex = null;
          isBusy = false;
        });

        if (matchedPairs == totalPairs) {
          _showWinDialog();
        }
      } else {
        // No match — flip both back after a short delay
        await Future.delayed(const Duration(milliseconds: 1000));
        if (!mounted) return;
        await Future.wait([
          _flipCard(index, faceUp: false),
          _flipCard(firstIndex, faceUp: false),
        ]);
        setState(() {
          cards[index].isClickable = true;
          cards[firstIndex].isClickable = true;
          firstSelectedIndex = null;
          isBusy = false;
        });
      }
    }
  }

  // Mirrors flipCard(): rotate out, swap the face mid-flip, rotate back in.
  Future<void> _flipCard(int index, {required bool faceUp}) async {
    final controller = flipControllers[index];
    controller.duration = const Duration(milliseconds: 150);

    await controller.forward(from: 0); // 0 -> 90 degrees
    setState(() {
      cards[index].isFaceUp = faceUp;
    });
    await controller.reverse(from: 1); // -90 -> 0 degrees (shown as mirrored forward)
  }

  void _showWinDialog() {
    _timer?.cancel();
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('You Win!'),
        content: const Text("Congratulations! You've matched all the cards."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _restartGame();
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop(); // leave the game screen, like finish()
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  void _showLoseDialog() {
    _timer?.cancel();
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text("Time's Up!"),
        content: const Text('You ran out of time. Try again!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _restartGame();
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  void _restartGame() {
    for (final c in flipControllers) {
      c.dispose();
    }
    _timer?.cancel();
    setState(() {
      _setupGameBoard();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in flipControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Left: ${secondsLeft}s'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_match.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 100.0, 8.0, 8.0),
          child: GridView.builder(
            itemCount: cards.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) => _CardTile(
              card: cards[index],
              controller: flipControllers[index],
              onTap: () => _onCardTapped(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardTile extends StatelessWidget {
  final _CardState card;
  final AnimationController controller;
  final VoidCallback onTap;

  const _CardTile({
    required this.card,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: card.isClickable ? onTap : null,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          // controller goes 0 -> 1 representing a 0deg -> 90deg -> 0deg flip.
          final angle = controller.value * pi / 2; // up to 90 degrees
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: child,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            card.isFaceUp ? imageMap[card.value]! : cardBackAsset,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
