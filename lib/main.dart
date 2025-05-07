import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF83D061),
        colorScheme: ColorScheme.dark(
          primary: Colors.purpleAccent,
          secondary: Colors.deepPurple,
        ),
      ),
      home: const TicTacToeGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> board = List.filled(9, '');
  bool xTurn = true;
  String result = '';

  static const List<List<int>> winConditions = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
    [0, 4, 8], [2, 4, 6],            // Diagonals
  ];

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      xTurn = true;
      result = '';
    });
  }

  void handleTap(int index) {
    if (board[index] != '' || result != '') return;

    setState(() {
      board[index] = xTurn ? 'X' : 'O';
      xTurn = !xTurn;
      checkWinner();
    });
  }

  void checkWinner() {
    for (var condition in winConditions) {
      String a = board[condition[0]];
      String b = board[condition[1]];
      String c = board[condition[2]];
      if (a != '' && a == b && b == c) {
        setState(() {
          result = '$a Wins!';
        });
        return;
      }
    }

    if (!board.contains('')) {
      setState(() {
        result = 'Draw!';
      });
    }
  }

  Widget buildBox(int index) {
    return GestureDetector(
      onTap: () => handleTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade800),
        ),
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(
              fontSize: 40,
              color: board[index] == 'X' ? Colors.purpleAccent : Colors.deepPurpleAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (_, index) => buildBox(index),
          ),
          const SizedBox(height: 20),
          Text(
            result,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetGame,
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
