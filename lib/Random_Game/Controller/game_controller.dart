import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_course/Random_Game/history.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  var selectedIndex = 0.obs;
  List<TextEditingController> textControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<String> _words = ['game', 'dart', 'code', 'tech', 'play'];
  final _isGuessedWordCorrect = false.obs;
  final _feedBack = ''.obs;
  final _score = 0.obs;
  final RxList<Guess> _guessedWords = <Guess>[].obs;
  final RxString _secretWord = ''.obs;

  String get secretWord => _secretWord.value;
  get isGuessedWordCorrect => _isGuessedWordCorrect.value;
  String get feedBack => _feedBack.value;
  int get score => _score.value;
  List<Guess> get guessedWord => _guessedWords;
  List<String> get words => _words;

  changePageIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    _secretWord.value = _words[Random().nextInt(_words.length)];
  }

  void setTextControllerText(int index, String text) {
    textControllers[index].text = text;
  }

  void clearTextFields() {
    for (var controller in textControllers) {
      controller.clear();
    }
  }

  void showSnackBar(String title, String message) {
    if (Get.context != null) {
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      print('$title: $message');
    }
  }

  void validateGuess() {
    String guess = textControllers.map((e) => e.text).join();
    if (guess.length != 4) {
      _feedBack.value = 'Word must be 4 letters long.';
      showSnackBar('Invalid Guess', 'Word must be 4 letters long.');
    } else {
      guessSecretWords(guess);
    }
  }

  void guessSecretWords(String guess) {
    print('beginning of guessSecretWords');
    print('secret word is: =========== $_secretWord');
    int scoreForthisGuess = 0;
    if (_words.contains(guess.toLowerCase())) {
      if (guess.toLowerCase() == _secretWord.value.toLowerCase()) {
        scoreForthisGuess = 10;
        _score.value += 10;

        _isGuessedWordCorrect.value = true;
        _feedBack.value = 'Congratulations! You guessed the secret word!';
        showSnackBar(
          'Correct Guess',
          'You guessed the secret word!\n score: ${_score.value}',
        );

        clearTextFields();
        _pickNewSecretWord();
      } else {
        _isGuessedWordCorrect.value = false;
        scoreForthisGuess = 0;
        showSnackBar(
          'Incorrect Guess',
          'The word is in the list but not the secret word.',
        );

        clearTextFields();
        _feedBack.value =
            'The word is in the list but not the secret word. Please Try again!';
      }
    } else {
      _feedBack.value = 'Word is not in the list. Please try again.';
      _isGuessedWordCorrect.value = false;
      scoreForthisGuess = 0;
      showSnackBar(
        'Invalid Guess',
        'The word is not in the list. Please try again.',
      );

      clearTextFields();
    }

    _guessedWords.add(
      Guess(
        guess: guess,
        feedback: _feedBack.value,
        score: scoreForthisGuess,
        isCorrect: isGuessedWordCorrect,
      ),
    );
  }

  void _pickNewSecretWord() {
    final availableWords = _words.where((w) => w != _secretWord.value).toList();
    _secretWord.value =
        availableWords[DateTime.now().microsecondsSinceEpoch %
            availableWords.length];
  }
}
