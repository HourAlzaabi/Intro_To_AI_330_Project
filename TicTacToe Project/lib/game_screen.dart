import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class GameScreen extends StatefulWidget {
  final String playerName;
  final String difficulty;
  final Color xColor;
  final Color oColor;
  final String firstMove;
  final String playerPiece;
  final String computerPiece;

  const GameScreen({
    super.key,
    required this.playerName,
    required this.difficulty,
    required this.xColor,
    required this.oColor,
    required this.firstMove,
    required this.playerPiece,
    required this.computerPiece,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ""));
  String currentPlayer = "X";
  bool gameOver = false;
  int playerWins = 0;
  int computerWins = 0;
  int draws = 0;
  int maxDepth = 1;
  List<List<int>> winningCells = [];
  late AnimationController _lineController;

  final AudioPlayer _clickPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  final AudioPlayer _winPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  Future<void> _playClick() async {
    try {
      await _clickPlayer.stop();
      await _clickPlayer.play(AssetSource('sounds/click.wav'), volume: 1.0);
    } catch (_) {
      try {
        await _clickPlayer.stop();
        await _clickPlayer.play(AssetSource('sounds/tap.wav'), volume: 1.0);
      } catch (_) {}
    }
  }

  Future<void> _playWin() async {
    try {
      await _winPlayer.stop();
      await _winPlayer.play(AssetSource('sounds/win.wav'), volume: 1.0);
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();

    if (widget.difficulty == "easy") {
      maxDepth = 1;
    } else if (widget.difficulty == "medium") {
      maxDepth = 3;
    } else {
      maxDepth = 9;
    }

    currentPlayer = widget.firstMove;

    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    if (currentPlayer == widget.computerPiece) {
      Future.delayed(const Duration(milliseconds: 400), computerMove);
    }
  }

  @override
  void dispose() {
    _lineController.dispose();
    _clickPlayer.dispose();
    _winPlayer.dispose();
    super.dispose();
  }

  void playMove(int i, int j) {
    if (board[i][j] != "" || gameOver) return;
    if (currentPlayer != widget.playerPiece) return;

    setState(() {
      board[i][j] = widget.playerPiece;
    });
    _playClick();

    if (checkWinner(widget.playerPiece)) {
      setState(() {
        playerWins++;
        gameOver = true;
        _lineController.forward(from: 0);
      });
      _playWin();
      showResultDialog("${widget.playerName} Wins!");
      return;
    }

    if (isDraw()) {
      setState(() {
        draws++;
        gameOver = true;
      });
      showResultDialog("It's a Draw!");
      return;
    }

    setState(() => currentPlayer = widget.computerPiece);
    Future.delayed(const Duration(milliseconds: 400), computerMove);
  }

  void computerMove() async {
    if (gameOver) return;
    await Future.delayed(const Duration(milliseconds: 400));

    double randomness = 0.0;
    if (widget.difficulty == "easy") randomness = 0.6;
    if (widget.difficulty == "medium") randomness = 0.25;

    List<List<int>> emptyCells = [];
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        if (board[r][c] == "") emptyCells.add([r, c]);
      }
    }
    if (emptyCells.isEmpty) return;

    List<int> move;
    if (Random().nextDouble() < randomness) {
      move = emptyCells[Random().nextInt(emptyCells.length)];
    } else {
      move = findBestMove(maxDepth);
    }

    if (gameOver) return;

    setState(() {
      board[move[0]][move[1]] = widget.computerPiece;
    });
    _playClick();

    if (checkWinner(widget.computerPiece)) {
      setState(() {
        computerWins++;
        gameOver = true;
        _lineController.forward(from: 0);
      });
      _playWin();
      showResultDialog("Computer Wins!");
    } else if (isDraw()) {
      setState(() {
        draws++;
        gameOver = true;
      });
      showResultDialog("It's a Draw!");
    } else {
      setState(() => currentPlayer = widget.playerPiece);
    }
  }

  int evaluateBoard() {
    if (checkWinner(widget.computerPiece)) return 10;
    if (checkWinner(widget.playerPiece)) return -10;
    return 0;
  }

  int minimax(List<List<String>> b, int depth, bool isMax) {
    int score = evaluateBoard();
    if (score == 10 || score == -10 || isDrawBoard(b) || depth == 0) return score;

    if (isMax) {
      int best = -1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (b[i][j] == "") {
            b[i][j] = widget.computerPiece;
            best = max(best, minimax(b, depth - 1, false));
            b[i][j] = "";
          }
        }
      }
      return best;
    } else {
      int best = 1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (b[i][j] == "") {
            b[i][j] = widget.playerPiece;
            best = min(best, minimax(b, depth - 1, true));
            b[i][j] = "";
          }
        }
      }
      return best;
    }
  }

  List<int> findBestMove(int depth) {
    int bestVal = -1000;
    List<int> bestMove = [-1, -1];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          board[i][j] = widget.computerPiece;
          int moveVal = minimax(board, depth, false);
          board[i][j] = "";
          if (moveVal > bestVal) {
            bestVal = moveVal;
            bestMove = [i, j];
          }
        }
      }
    }
    if (bestMove[0] == -1) {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == "") return [i, j];
        }
      }
    }
    return bestMove;
  }

  bool checkWinner(String p) {
    winningCells.clear();
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == p && board[i][1] == p && board[i][2] == p) {
        winningCells = [[i, 0], [i, 1], [i, 2]];
        return true;
      }
    }
    for (int j = 0; j < 3; j++) {
      if (board[0][j] == p && board[1][j] == p && board[2][j] == p) {
        winningCells = [[0, j], [1, j], [2, j]];
        return true;
      }
    }
    if (board[0][0] == p && board[1][1] == p && board[2][2] == p) {
      winningCells = [[0, 0], [1, 1], [2, 2]];
      return true;
    }
    if (board[0][2] == p && board[1][1] == p && board[2][0] == p) {
      winningCells = [[0, 2], [1, 1], [2, 0]];
      return true;
    }
    return false;
  }

  bool isDraw() => board.expand((r) => r).every((c) => c != "");
  bool isDrawBoard(List<List<String>> b) =>
      b.expand((r) => r).every((c) => c != "");

  void resetBoard() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ""));
      gameOver = false;
      winningCells.clear();
      _lineController.reset();
      currentPlayer = widget.firstMove;
    });
    if (currentPlayer == widget.computerPiece) {
      Future.delayed(const Duration(milliseconds: 400), computerMove);
    }
  }

  void showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetBoard();
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFDCC8A7), // modern warm beige background
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(2, 2))
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF5D4037), // brown arrow
                      ),
                    ),
                  ),
                ),
              ),

              // Scoreboard
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _scoreBadge(Icons.person, "${widget.playerPiece} ${widget.playerName}",
                      playerWins, widget.playerPiece == "X" ? widget.xColor : widget.oColor),
                  _scoreBadge(Icons.handshake_rounded, "Draws", draws, Colors.brown),
                  _scoreBadge(Icons.computer, "${widget.computerPiece} Computer",
                      computerWins, widget.computerPiece == "X" ? widget.xColor : widget.oColor),
                ],
              ),

              // Game Board
              Container(
                width: 300,
                height: 300,
                padding: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        int i = index ~/ 3;
                        int j = index % 3;
                        bool isWinningCell =
                        winningCells.any((cell) => cell[0] == i && cell[1] == j);

                        return InkWell(
                          onTap: () => playMove(i, j),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.all(4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isWinningCell
                                  ? Colors.green.withOpacity(0.6)
                                  : Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Text(
                              board[i][j],
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: board[i][j] == "X"
                                    ? widget.xColor
                                    : board[i][j] == "O"
                                    ? widget.oColor
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: AnimatedBuilder(
                        animation: _lineController,
                        builder: (_, __) => CustomPaint(
                          size: const Size(300, 300),
                          painter:
                          WinLinePainter(winningCells, _lineController.value),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Restart Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF5D4037), // brown text
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: resetBoard,
                child: const Text(
                  "Restart Game",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scoreBadge(
      IconData icon, String label, int score, Color color) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 10)],
          ),
          child: Center(
            child: Text(
              score.toString().padLeft(2, '0'),
              style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Icon(
          icon,
          color: Color(0xFF5D4037), // brown icons
          size: 20,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF5D4037), // brown labels
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class WinLinePainter extends CustomPainter {
  final List<List<int>> winCells;
  final double progress;

  WinLinePainter(this.winCells, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (winCells.isEmpty) return;

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final start = Offset(
      winCells.first[1] * size.width / 3 + size.width / 6,
      winCells.first[0] * size.height / 3 + size.height / 6,
    );
    final end = Offset(
      winCells.last[1] * size.width / 3 + size.width / 6,
      winCells.last[0] * size.height / 3 + size.height / 6,
    );

    final currentEnd = Offset.lerp(start, end, progress)!;
    canvas.drawLine(start, currentEnd, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}