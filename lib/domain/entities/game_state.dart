import '../../data/models/guess_model.dart';

class GameState {
  final String secretWord;
  final List<GuessModel> guesses;
  final int score;
  final bool isGameActive;

  GameState({
    required this.secretWord,
    required this.guesses,
    required this.score,
    required this.isGameActive,
  });
}
