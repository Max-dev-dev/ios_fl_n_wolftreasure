import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_wolftreasury_3369/cubit/wolf_place_cubit.dart';
import 'package:ios_fl_n_wolftreasury_3369/pages/welcome/welcome_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WolfPlaceCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                ),
              ),
              child ?? const SizedBox.shrink(),
            ],
          );
        },
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF10133A),
            scrolledUnderElevation: 0,
          ),
          scaffoldBackgroundColor: const Color(0xFF10133A),
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
