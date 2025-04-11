import 'package:flutter/material.dart';
import 'package:ios_fl_n_wolftreasury_3369/pages/quizz/WolfQuizScreen.dart';

class QuizPreviewScreen extends StatelessWidget {
  const QuizPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 23,
                        vertical: 23,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB4773A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
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
              SizedBox(height: 100),
              Text(
                'The world of wolves is not just a pack. It`s characters, instincts, roles. Some lead. Some observe. Some keep quiet until the time is right.\n\n Take this short quiz and find out who you are in the world of wolves:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 60),
              SizedBox(
                width: 150.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WolfQuizScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB4773A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'LETS GO',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Colors.white,
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
    );
  }
}
