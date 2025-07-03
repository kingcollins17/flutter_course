import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/usecases/game_usecase.dart';
import '../../data/models/guess_model.dart';

class GameController extends GetxController {
  final GameUsecase _gameUsecase = GameUsecase();
  final TextEditingController textController = TextEditingController();

  final Rx<GameState> _gameState =
      GameState(secretWord: '', guesses: [], score: 0, isGameActive: true).obs;

  String get secretWord => _gameState.value.secretWord;
  List<GuessModel> get guesses => _gameState.value.guesses;
  int get score => _gameState.value.score;
  bool get isGameActive => _gameState.value.isGameActive;

  @override
  void onInit() {
    super.onInit();
    startNewGame();
  }

  void startNewGame() {
    _gameState.value = _gameUsecase.initializeGame();
    textController.clear();
  }

  void submitGuess() {
    final guess = textController.text.trim();
    if (guess.isEmpty || guess.length != 4) {
      Get.snackbar(
        'Invalid Input',
        'Please enter a 4-letter word',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    _gameState.value = _gameUsecase.processGuess(_gameState.value, guess);
    textController.clear();

    final lastGuess = guesses.last;
    if (lastGuess.isCorrect) {
      Get.snackbar(
        '🎉 Correct!',
        'Well done! You earned 10 points!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        '❌ Try Again',
        'Keep going! You can do it!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 1),
      );
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
