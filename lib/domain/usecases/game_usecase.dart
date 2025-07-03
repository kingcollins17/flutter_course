import '../entities/game_state.dart';
import '../../data/models/guess_model.dart';
import '../../data/repositories/word_repository.dart';

class GameUsecase {
  final WordRepository _wordRepository = WordRepository();

  GameState initializeGame() {
    return GameState(
      secretWord: _wordRepository.getRandomWord(),
      guesses: [],
      score: 0,
      isGameActive: true,
    );
  }

  GameState processGuess(GameState currentState, String guess) {
    if (!_wordRepository.isValidWord(guess)) {
      return currentState;
    }

    final upperGuess = guess.toUpperCase();
    final isCorrect = upperGuess == currentState.secretWord;

    final newGuess = GuessModel(
      word: upperGuess,
      isCorrect: isCorrect,
      timestamp: DateTime.now(),
    );

    final newGuesses = [...currentState.guesses, newGuess];
    final newScore = isCorrect ? currentState.score + 10 : currentState.score;

    return GameState(
      secretWord: currentState.secretWord,
      guesses: newGuesses,
      score: newScore,
      isGameActive: currentState.isGameActive,
    );
  }

  GameState resetGame() {
    return initializeGame();
  }
}
