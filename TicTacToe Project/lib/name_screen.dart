import 'package:flutter/material.dart';
import 'setup_screen.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFDCC8A7), // background color
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tic Tac Toe image
                Image.asset(
                  'assets/images/tic_tac_toe_logo.png',
                  height: 140,
                ),
                const SizedBox(height: 40),
                // Title
                const Text(
                  "Welcome to Tic Tac Toe!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Enter your name to get started",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF5D4037),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Name input
                TextField(
                  controller: nameController,
                  style: const TextStyle(
                    color: Color(0xFF5D4037),
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: "Your name",
                    hintStyle: const TextStyle(color: Colors.brown),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.brown),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Continue button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF5D4037),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    if (nameController.text.isEmpty) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetupScreen(
                          playerName: nameController.text,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    color: Color(0xFF5D4037),
                  ),
                  label: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}