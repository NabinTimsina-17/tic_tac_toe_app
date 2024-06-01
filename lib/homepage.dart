import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Icon Images
  final cross = const Icon(Icons.cancel, size: 80);
  final circle = const Icon(Icons.circle, size: 80);
  final edit = const Icon(Icons.edit, size: 80);

  bool isCross = true;
  String message = "";
  late List<String> gameState;

  // Initialize the game state
  @override
  void initState() {
    super.initState();
    gameState = List.filled(9, "empty");
  }

  // Play the game
  void playGame(int index) {
    if (gameState[index] == "empty") {
      setState(() {
        gameState[index] = isCross ? "cross" : "circle";
        isCross = !isCross;
        checkWin();
      });
    }
  }

  // Reset the game
  void resetGame() {
    setState(() {
      gameState = List.filled(9, "empty");
      message = "";
      isCross = true;
    });
  }

  // Get Icon Image
  Icon getIcon(String title) {
    switch (title) {
      case 'cross':
        return cross;
      case 'circle':
        return circle;
      default:
        return edit;
    }
  }

  // Check for a win
  void checkWin() {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var pattern in winPatterns) {
      if (gameState[pattern[0]] != 'empty' &&
          gameState[pattern[0]] == gameState[pattern[1]] &&
          gameState[pattern[1]] == gameState[pattern[2]]) {
        setState(() {
          message = '${gameState[pattern[0]]} wins';
        });
        return;
      }
    }

    if (!gameState.contains('empty')) {
      setState(() {
        message = "Game Draw";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.0, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: gameState.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100,
                height: 100,
                child: MaterialButton(
                  onPressed: () {
                    playGame(i);
                  },
                  child: getIcon(gameState[i]),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: resetGame,
            child: const Text("Reset Game"),
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text("#FlutterWithNabin"),
          ),
        ],
      ),
    );
  }
}
