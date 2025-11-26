import 'package:flutter/material.dart';
import 'package:ai_project/name_screen.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', // Or any default font
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontWeight: FontWeight.bold),
          labelLarge: TextStyle(fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
      home: const NameScreen(),
    );
  }
}