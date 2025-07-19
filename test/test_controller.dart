import 'package:flutter_course/controllers/game_controller.dart';
import 'package:flutter_course/models/word_model.dart';

class TestGameController extends GameController {
  @override
  void gameSnackBar(
    String titleString,
    String messageString, {
    bool? isCorrect = false,
    Duration? duration = const Duration(seconds: 2),
  }) {
    //do nothing
  }

  @override
  List<WordModel> get remainingWords => [
    WordModel(
      word: "love",
      wordhints: [
        "It means affection",
        "Can mean 'like deeply'",
        "Another word for fondness",
      ],
    ),
  ];
}
