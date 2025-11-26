import 'package:flutter/material.dart';
import 'game_screen.dart';

class SetupScreen extends StatefulWidget {
  final String playerName;

  const SetupScreen({super.key, required this.playerName});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  String difficulty = "easy";
  String chosenPiece = "X";
  Color xColor = Colors.deepOrange;
  Color oColor = Colors.blueAccent;
  String firstMove = "player";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFDCC8A7),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "🎮 Let's Play!",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Hi ${widget.playerName}! Customize your match below 👇",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF5D4037),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Difficulty
                _sectionCard(
                  title: "Difficulty",
                  icon: Icons.bar_chart_rounded,
                  child: Wrap(
                    spacing: 12,
                    children: [
                      _difficultyButton("Easy", "easy", Colors.green),
                      _difficultyButton("Medium", "medium", Colors.orange),
                      _difficultyButton("Hard", "hard", Colors.redAccent),
                    ],
                  ),
                ),
                // Who starts
                _sectionCard(
                  title: "Who Starts?",
                  icon: Icons.play_arrow_rounded,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _whoStartsButton("👤 You", "player"),
                      const SizedBox(width: 20),
                      _whoStartsButton("💻 Computer", "computer"),
                    ],
                  ),
                ),
                // Piece
                _sectionCard(
                  title: "Your Piece",
                  icon: Icons.widgets_rounded,
                  child: Wrap(
                    spacing: 20,
                    children: [
                      _pieceButton("X"),
                      _pieceButton("O"),
                    ],
                  ),
                ),
                // Colors
                _sectionCard(
                  title: "Colors",
                  icon: Icons.palette_rounded,
                  child: Wrap(
                    spacing: 15,
                    children: [
                      _colorChoice(Colors.deepOrange, Colors.blueAccent),
                      _colorChoice(Colors.purple, Colors.orangeAccent),
                      _colorChoice(Colors.pinkAccent, Colors.teal),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF5D4037),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    String playerPiece = chosenPiece;
                    String computerPiece = chosenPiece == "X" ? "O" : "X";
                    // first move symbol
                    String firstMoveSymbol =
                    firstMove == "player" ? playerPiece : computerPiece;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameScreen(
                          playerName: widget.playerName,
                          difficulty: difficulty,
                          xColor: xColor,
                          oColor: oColor,
                          firstMove: firstMoveSymbol,
                          playerPiece: playerPiece,
                          computerPiece: computerPiece,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.sports_esports),
                  label: const Text(
                    "Start Game",
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

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF5D4037)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _difficultyButton(String label, String value, Color color) {
    bool selected = difficulty == value;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? color : Colors.white,
        foregroundColor: selected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: Colors.black26,
        elevation: selected ? 5 : 2,
      ),
      onPressed: () => setState(() => difficulty = value),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _whoStartsButton(String label, String value) {
    bool selected = firstMove == value;
    return GestureDetector(
      onTap: () => setState(() => firstMove = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white24,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: selected ? Colors.orangeAccent : Colors.brown.shade300,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: selected ? Colors.deepOrange : const Color(0xFF5D4037),
          ),
        ),
      ),
    );
  }

  Widget _pieceButton(String symbol) {
    bool selected = chosenPiece == symbol;
    return GestureDetector(
      onTap: () => setState(() => chosenPiece = symbol),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white24,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected ? Colors.orangeAccent : Colors.brown.shade300,
            width: 2,
          ),
        ),
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: selected ? Colors.deepOrange : const Color(0xFF5D4037),
          ),
        ),
      ),
    );
  }

  Widget _colorChoice(Color xCol, Color oCol) {
    bool selected = (xColor == xCol && oColor == oCol);
    return GestureDetector(
      onTap: () => setState(() {
        xColor = xCol;
        oColor = oCol;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? Colors.white70 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.brown.shade400, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "X",
              style: TextStyle(
                fontSize: 28,
                color: xCol,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              "O",
              style: TextStyle(
                fontSize: 28,
                color: oCol,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}