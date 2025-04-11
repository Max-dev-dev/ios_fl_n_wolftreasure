import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ios_fl_n_wolftreasury_3369/pages/tutorial/tutorial_screen.dart';

class LaunchTracker {
  static final LaunchTracker _instance = LaunchTracker._privateConstructor();

  bool _wasLaunched = true;

  factory LaunchTracker() => _instance;

  LaunchTracker._privateConstructor();

  bool get isInitialLaunch => _wasLaunched;

  void markLaunchComplete() {
    _wasLaunched = false;
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _startAppFlow();
  }

  void _startAppFlow() {
    final shouldShowIntro = LaunchTracker().isInitialLaunch;

    if (shouldShowIntro) {
      LaunchTracker().markLaunchComplete();
    }

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              shouldShowIntro ? const TutorialScreen() : const TutorialScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SizedBox(
              width: 226,
              height: 28,
              child: CustomPaint(
                painter: _LoaderPainter(_controller.value),
                child: SizedBox(width: 226, height: 28),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  final double progress;

  _LoaderPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint =
        Paint()
          ..color = const Color(0xFF766DF4)
          ..style = PaintingStyle.fill;

    final borderPaint =
        Paint()
          ..color = const Color(0xFF766DF4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    final radius = Radius.circular(10);
    final rect = RRect.fromRectAndRadius(Offset.zero & size, radius);

    canvas.drawRRect(rect, backgroundPaint);
    canvas.drawRRect(rect, borderPaint);

    canvas.save();
    canvas.clipRRect(rect);

    final stripePaint =
        Paint()
          ..color = Colors.white.withOpacity(0.8)
          ..style = PaintingStyle.fill;

    const stripeWidth = 30.0;
    const stripeSpacing = 10.0;
    final totalWidth = stripeWidth + stripeSpacing;

    final animatedOffset = progress * totalWidth;

    for (
      double x = -totalWidth * 2 + animatedOffset;
      x < size.width + totalWidth * 2;
      x += totalWidth
    ) {
      final path = Path();
      path.moveTo(x, 0);
      path.lineTo(x + stripeWidth / 2, 0);
      path.lineTo(x + stripeWidth, size.height);
      path.lineTo(x + stripeWidth / 2, size.height);
      path.close();

      canvas.drawPath(path, stripePaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _LoaderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
