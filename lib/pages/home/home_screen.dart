// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_fl_n_wolftreasury_3369/pages/map/map_page.dart';
import 'package:ios_fl_n_wolftreasury_3369/pages/myths/myth_category_screen.dart';
import 'package:ios_fl_n_wolftreasury_3369/pages/places/saved_wolf_places.dart';
import 'package:ios_fl_n_wolftreasury_3369/pages/quizz/quiz_preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<String> wolfQuotes = [
    "A wolf can hear your heartbeat… from 3 km away.\nIts hearing is ten times more sensitive than a human’s.",
    "A real wolf doesn't howl - it's silent.\nThey rarely use sound in their hunt. Silence is their weapon.",
    "Wolves have deep family bonds.\nThey mourn the death of a pack member. Yes, for real.",
    "In the wild, a wolf can travel up to 80 km per day.\nAnd without GPS.",
    "A wolf's eyes change from yellow to amber depending on the light.\nIf a wolf looks straight at you, it doesn't see your eyes, it sees your intent.",
    "A wolf does not abandon his pack - until he is betrayed.",
    "When a wolf howls, the others are silent.\nIt is a sign of respect. In a pack, they speak in turns.",
    "Their paws have webbed feet.\nYes, the wolf can swim.",
    "Each pack has a unique “wolf name.”\nIt can be recognized by the rhythm of the howl.",
    "Sometimes the wolf lets the omega win the game.\nHe trains the younger ones, doesn't kill their confidence.",
    "Wolves are not afraid of the cold - they are afraid of hunger.",
    "Their fur consists of two layers.\nOne is warm, the other repels water.",
    "Some wolves leave the pack voluntarily.\nAnd start a new one. Like true travelers.",
    "In Poland, wolves were listed in the Red Book and then restored.\nThe true story of the return of the wild.",
    "Wolves never hunt for fun.\nOnly survival. They are not wasteful.",
    "The Ethiopian wolf is one of the rarest in the world.\nThere are fewer than 500 left.",
  ];

  late Timer _timer;
  Duration _timeLeft = const Duration(hours: 23, minutes: 59, seconds: 59);
  late int _quoteIndex;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    _timeLeft = midnight.difference(now);

    _quoteIndex = now.difference(DateTime(2024)).inDays % wolfQuotes.length;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _timeLeft -= const Duration(seconds: 1);
        if (_timeLeft.isNegative) {
          _quoteIndex = (_quoteIndex + 1) % wolfQuotes.length;
          _timeLeft = const Duration(hours: 24);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:"
        "${twoDigits(duration.inMinutes.remainder(60))}:"
        "${twoDigits(duration.inSeconds.remainder(60))}";
  }

  Widget _buildButton(IconData icon, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFB4773A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(icon, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/app_logo.png', width: 240),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'The life of a wolf:',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.timer, color: Color(0xFFB4773A)),
                        const SizedBox(width: 4),
                        Text(
                          _formatDuration(_timeLeft),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB4773A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      wolfQuotes[_quoteIndex],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildButton(FontAwesomeIcons.mapMarkedAlt, 'View map', () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WildExplorerMap(),
                      ),
                    );
              }),
              _buildButton(FontAwesomeIcons.paw, 'A look into the myth', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MythCategoryScreen(),
                  ),
                );
              }),
              _buildButton(FontAwesomeIcons.bookmark, 'Saved location', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavedWolfPlaces(),
                  ),
                );
              }),
              _buildButton(
                FontAwesomeIcons.question,
                'What kind of wolf are you?',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizPreviewScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
