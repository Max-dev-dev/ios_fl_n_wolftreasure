import 'package:flutter/material.dart';
import 'package:ios_fl_n_wolftreasury_3369/pages/home/home_screen.dart';
import 'package:logger/logger.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  int _currentSlide = 0;

    final List<String> _onboardImage = [
    'assets/images/onboard/1.png',
    'assets/images/onboard/2.png',
    'assets/images/onboard/3.png',
  ];

  final List<String> _titles = [
    'Where does the wolf live?'.toUpperCase(),
    'Reserves where wolves\nare still free'.toUpperCase(),
    'Find your totem wolf'.toUpperCase(),
  ];

  final List<String> _descriptions = [
    'From the cliffs of Alaska to the forests of the Carpathians, wolves are still here.\nThey don`t disappear. They don`t give up. They just hide.\nTake a look at the places where the howl hasn`t been lost in the noise of the world.',
    'Discover real-world locations around the world:\nsanctuaries, research centers, wild forests where wolves live, recover, and... inspire.\n\nEvery map is a story. Every pack is real.',
    'Take a short test and find out who you are in the pack.\nA loner? A leader? A protector?\nBecause sometimes, to find a wolf, you have to find yourself.',
  ];

  final List<String> _buttonLabels = ['Explore the territories', 'See map', 'Define your spirit'];

  void _goToNextSlide() {
    if (_currentSlide < _titles.length - 1) {
      setState(() {
        _currentSlide++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    Logger().i('Screen Height: $screenHeight');

    return Stack(
      children: [
          Positioned.fill(
            child: Image.asset(_onboardImage[_currentSlide], fit: BoxFit.cover),
          ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    _titles[_currentSlide],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    _descriptions[_currentSlide],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 28.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: GestureDetector(
                    onTap: _goToNextSlide,
                    child: Container(
                      width: 300.0,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      decoration: BoxDecoration(
                        color: Color(0xFFB4773A),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          _buttonLabels[_currentSlide],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
