// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ios_fl_n_wolftreasury_3369/pages/quizz/WolfResultScreen.dart';

class WolfQuizScreen extends StatefulWidget {
  const WolfQuizScreen({super.key});

  @override
  State<WolfQuizScreen> createState() => _WolfQuizScreenState();
}

class _WolfQuizScreenState extends State<WolfQuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      'question':
          "The forest is silent. You hear a sound in the shadows. What do you do?",
      'answers': [
        "I stop and listen. I hear not noise, but intention.",
        "I walk on. If it comes, I will accept it.",
        "I move around - I want to see before it sees me.",
      ]
    },
    {
      'question':
          "Your pack is at a crossroads. Opinions differ. What do you say?",
      'answers': [
        "Follow me. I see the way.",
        "I don't argue - I'm just going my own way.",
        "We'll listen to everyone. But listen not only to your ears, but also to your heart.",
      ]
    },
    {
      'question':
          "Winter is coming. Cold, hungry. What is most important to you?",
      'answers': [
        "Being together - only the pack will survive.",
        "Getting ready. The cold is not an enemy, it's a habit.",
        "The cold doesn't scare me. I've been walking alone for a long time.",
      ]
    },
    {
      'question': "You see injustice. What awakens in you?",
      'answers': [
        "I defend. Without noise, without shouting. I just stand up.",
        "I will come out of the shadows and say it to your face. Not for the stage - for the truth.",
        "I will remember. My revenge is the silence that comes at night.",
      ]
    },
    {
      'question': "When you are alone, what do you feel?",
      'answers': [
        "Peace. Solitude is not loneliness.",
        "Anxiety. I was created for the voices around me.",
        "Strength. My path is my choice.",
      ]
    },
  ];

  int currentIndex = 0;
  int? selectedAnswer;

  void _selectAnswer(int index) {
    if (selectedAnswer != null) return;

    setState(() => selectedAnswer = index);

    Future.delayed(const Duration(seconds: 1), () {
      if (currentIndex < questions.length - 1) {
        setState(() {
          currentIndex++;
          selectedAnswer = null;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const WolfResultScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentIndex];
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 100),
              Text(
                '${currentIndex + 1}. ${currentQuestion['question']}'.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              ...List.generate(3, (i) {
                final isSelected = selectedAnswer == i;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () => _selectAnswer(i),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFB4773A)
                              : Colors.white,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        '${String.fromCharCode(65 + i)}) ${currentQuestion['answers'][i]}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.95),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
