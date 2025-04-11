import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class WolfResultScreen extends StatelessWidget {
  const WolfResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> results = [
      {
        'type': 'ALPHA'.toUpperCase(),
        'description':
            'is a leader with a sharp eye and difficult choices.'.toUpperCase(),
        'image': 'assets/images/quiz_result/1.png',
      },
      {
        'type': 'The Pathfinder'.toUpperCase(),
        'description':
            'walks alone, not because he is lost, but because he knows his path.'.toUpperCase(),
         'image': 'assets/images/quiz_result/2.png',
      },
      {
        'type': 'A rebel'.toUpperCase(),
        'description':
            'is not a pack, not an enemy, but always in his own way'.toUpperCase(),
         'image': 'assets/images/quiz_result/3.png',
      },
    ];

    final randomResult = results[Random().nextInt(results.length)];

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB4773A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'What kind of wolf are you?',
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  randomResult['type']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  randomResult['description']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    randomResult['image']!,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _iconButton(Icons.home, () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }),
                    const SizedBox(width: 16),
                    _iconButton(Icons.share, () {
                      Share.share("I'm the ${randomResult['type']} wolf 🐺");
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color(0xFFB4773A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
