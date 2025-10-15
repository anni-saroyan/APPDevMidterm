import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameBloc(),
      child: const RockPaperScissorsApp(),
    ),
  );
}

class RockPaperScissorsApp extends StatelessWidget {
  const RockPaperScissorsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Paper Scissor',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const GamePage(),
    );
  }
}

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rock Paper Scissors'),
        centerTitle: true,
      ),
      body: Center(
        child: bloc.result.isEmpty
            ? const Text('Tap PLAY to start!', style: TextStyle(fontSize: 20))
            : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You chose: ${bloc.playerChoice}',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Computer chose: ${bloc.computerChoice}',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text(
              bloc.result,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: bloc.result == 'You Win!'
                    ? Colors.green
                    : bloc.result == 'You Lose!'
                    ? Colors.red
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.playGame(context),
        tooltip: 'Play',
        child: const Icon(Icons.sports_kabaddi),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class GameBloc extends ChangeNotifier {
  final List<String> _choices = ['Rock', 'Paper', 'Scissors'];
  final Random _random = Random();

  String playerChoice = '';
  String computerChoice = '';
  String result = '';

  Future<void> playGame(BuildContext context) async {
    final choice = await _showChoiceDialog(context);
    if (choice == null) return;

    final compChoice = _choices[_random.nextInt(3)];
    final gameResult = _calculateResult(choice, compChoice);

    playerChoice = choice;
    computerChoice = compChoice;
    result = gameResult;

    notifyListeners();
  }

  String _calculateResult(String player, String computer) {
    if (player == computer) return "It's a Draw!";
    if ((player == 'Rock' && computer == 'Scissors') ||
        (player == 'Paper' && computer == 'Rock') ||
        (player == 'Scissors' && computer == 'Paper')) {
      return 'You Win!';
    }
    return 'You Lose!';
  }

  Future<String?> _showChoiceDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose your move'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _choices
              .map(
                (c) => ListTile(
              title: Text(c),
              onTap: () => Navigator.of(context).pop(c),
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}
