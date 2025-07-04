import 'package:flutter/material.dart';
import 'package:flutter_course/data/word_data.dart';
import 'package:flutter_course/methods.dart';
import 'package:flutter_course/models/word_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/guess_model.dart';

class GameController extends GetxController {
  late WordModel secretWord;
  var remainingTry = 2.obs;
  var previousGuess = <GuessModel>[].obs;
  var currentScore = 0.obs;
  final Box guessBox = Hive.box("guesses");
  List<WordModel> remainingWords = [...wordList];
  var gameOver = false.obs;
  var displayMainHint = false.obs;
  var newGuessMessage = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadGame();
  }

  void loadGame() {
    final guesses = guessBox.get('history', defaultValue: []) as List;
    previousGuess.assignAll(List<GuessModel>.from(guesses));
    currentScore.value = guessBox.get('score', defaultValue: 0);
    startNewGame();
    displayMainHint.value = true;
  }

  void startNewGame() {
    secretWord = pickNewWord();
    remainingTry.value = 10;
  }

  void getNewWord() {
    try {
      secretWord = pickNewWord();
    } catch (e) {
      gameSnackBar(
        'Congratulations',
        'You have completed the game. You scored ${currentScore.value} points!\nRestart the Game',
        Colors.green,
        duration: Duration(seconds: 3),
      );
      gameOver.value = true;
    }
  }

  WordModel pickNewWord() {
    if (remainingWords.isEmpty) throw Exception("No more words!");
    remainingWords.shuffle();
    return remainingWords.removeLast();
  }

  void assessGuess(String guess) {
    if (guess.length != 4 || remainingTry.value == 0) return;
    final String currentWord = secretWord.word;
    final isCorrect = guess == currentWord;
    final feedback = isCorrect ? "✅ Correct!" : "❌ Try again!";
    final hints = isCorrect ? null : generateHints(guess);

    previousGuess.add(
      GuessModel(word: guess, feedback: feedback, hints: hints),
    );
    guessBox.put('history', previousGuess.toList());

    if (isCorrect) {
      currentScore.value += 10;
      guessBox.put('score', currentScore.value);
      gameSnackBar('', "10 points added", Colors.green);
      getNewWord();
      newGuessMessage.value = true;
    } else {
      remainingTry.value--;
      if (remainingTry.value == 0) {
        gameSnackBar(
          'Game Over',
          'You scored ${currentScore.value} points!\n Restart the Game',
          Colors.red,
          duration: Duration(seconds: 7),
        );
        gameOver.value = true;
      }
    }
  }

  List<String> generateHints(String guess) {
    List<String> hints = [];
    int index = getRandomIndex(secretWord.wordhints);
    hints.add(secretWord.wordhints[index]);
    return hints.take(1).toList();
  }

  SnackbarController gameSnackBar(
    String titleString,
    String messageString,
    Color backgroundColor, {
    SnackPosition? position = SnackPosition.TOP,
    Duration? duration = const Duration(seconds: 2),
  }) {
    return Get.snackbar(
      titleString,
      messageString,
      colorText: Colors.white,
      backgroundColor: backgroundColor,
      duration: duration,
      snackPosition: position,
    );
  }

  void resetGame() {
    previousGuess.clear();
    gameOver.value = false;
    currentScore.value = 0;
    guessBox.put('history', []);
    guessBox.put('score', 0);
    remainingWords = [...wordList];
    startNewGame();
  }
}
