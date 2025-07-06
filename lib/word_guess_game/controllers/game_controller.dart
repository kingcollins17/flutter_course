import 'package:get/get.dart';
import 'dart:math';

class GameController extends GetxController {
  final List<String> wordList = ['frog', 'jump', 'tree', 'game', 'cold', 'fire'];

  late String secretWord;

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
    print("Secret word: $secretWord"); // Remove this later
  }

  void makeGuess(String guess) {
    if (guess.length != 4) return;

    if (guess == secretWord) {
      score += 10;
      guessHistory.add({"guess": guess, "feedback": "✅ Correct!"});
      _generateSecretWord(); // generate a new word
    } else {
      guessHistory.add({"guess": guess, "feedback": "❌ Try again"});
    }
  }
}
