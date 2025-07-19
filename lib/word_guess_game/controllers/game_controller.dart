import 'package:get/get.dart';
import 'dart:math';

class GameController extends GetxController {
  final List<String> wordList;

  GameController({List<String>? words})
      : wordList = words ?? ['frog', 'jump', 'tree', 'game', 'cold', 'fire'];

  late String secretWord;
  bool isCorrectGuess = false;

  var score = 0.obs;
  var guessHistory = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _generateSecretWord();
  }

  void _generateSecretWord() {
    final random = Random();
    secretWord = wordList[random.nextInt(wordList.length)];
    print("Secret word: $secretWord"); // For debugging
  }

  void validateGuess(String guess) {
    if (guess.length != 4) {
      throw ArgumentError('Guess must be exactly 4 letters.');
    }
    isCorrectGuess = guess.toLowerCase() == secretWord.toLowerCase();
  }

  bool makeGuess(String guess) {
    if (guess.length != 4) {
      throw ArgumentError('Guess must be 4 letters.');
    }

    final isCorrect = guess == secretWord;

    if (isCorrect) {
      score += 10;
      guessHistory.add({"guess": guess, "feedback": "✅ Correct!"});
      _generateSecretWord(); // new word
    } else {
      guessHistory.add({"guess": guess, "feedback": "❌ Try again"});
    }

    return isCorrect;
  }
}