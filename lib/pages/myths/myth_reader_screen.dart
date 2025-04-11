import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MythReaderScreen extends StatefulWidget {
  final String category;

  const MythReaderScreen({super.key, required this.category});

  @override
  State<MythReaderScreen> createState() => _MythReaderScreenState();
}

class _MythReaderScreenState extends State<MythReaderScreen> {
  int _currentIndex = 0;

  late final List<String> paragraphs;
  late final String title;
  late final String imagePath;

  @override
  void initState() {
    super.initState();

    switch (widget.category) {
      case 'Antiquity':
        title = "Lupercus - the wolf that fed Rome";
        imagePath = 'assets/images/myths/1.png';
        paragraphs = [
          "Rome was founded by the brothers Romulus and Remus, abandoned on the banks of the Tiber. They were sentenced to death, but a she-wolf, hearing their cry, came out of the forest, took them into her mouth - and did not eat them.",
          "She fed them with milk, protected them from predators and people. Seeing this, people called her Lupercus - \"the one who protects.\" She became a sacred animal, a symbol of strength, loyalty and protection.",
          "In her honor, the Lupercalia festival was held every year, where young men, dressed in wolf skins, ran through the streets and blessed fertility and new life.",
        ];
        break;
      case 'The First Howl':
        title = "The one who howls first";
        imagePath = 'assets/images/myths/2.png';
        paragraphs = [
          "In the days of the first people, there was no sound on earth. Everything was silent. Then the spirit of the wolf raised its head to the stars and took off.",
          "His howl woke the earth. The mountains roared, the trees began to rustle, and people heard themselves for the first time.",
          "Since then, the wolf has been considered the “first singer of the world” among the Navajo. It is not hunted without reason, it is not killed in silence.\nBecause when the world becomes too loud again, only the wolf will remind you that silence is strength.",
        ];
        break;
      case 'Asia and Shamanism':
        title = "White Wolf - the ancestor of the tribe";
        imagePath = 'assets/images/myths/3.png';
        paragraphs = [
          "In Mongolian legend, the founder of a great nation is descended from the union of the White Wolf and the Deer.",
          "The wolf came from the east, from the fiery sky, and his eyes were like icy fire. He did not hunt, he chose.",
          "The deer led him to the mountains, where they gave birth to the first people. When the descendants forgot about nature, the wolf went into the desert. When they remembered, he returned in a dream.",
        ];
        break;
      default:
        title = "Unknown Myth";
        imagePath = '';
        paragraphs = [];
    }
  }

  void _nextParagraph() {
    if (_currentIndex < paragraphs.length - 1) {
      setState(() => _currentIndex++);
    } else {
      Share.share('${title.toUpperCase()}\n\n${paragraphs.join("\n\n")}');
    }
  }

  void _prevParagraph() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                          horizontal: 25,
                          vertical: 25,
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
                      child: Text(
                        widget.category.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                if (imagePath.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(imagePath, height: 300, fit: BoxFit.cover),
                  ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_currentIndex + 1}/${paragraphs.length}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFFBEBEBE),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        paragraphs[_currentIndex],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_currentIndex > 0)
                      _navButton(Icons.arrow_back, _prevParagraph),
                    const SizedBox(width: 12),
                    _navButton(
                      _currentIndex == paragraphs.length - 1
                          ? Icons.share
                          : Icons.arrow_forward,
                      _nextParagraph,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFB4773A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
