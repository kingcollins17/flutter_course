import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_course/presentation/controllers/game_controller.dart';
import '../../test_helpers/test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GameController Tests', () {
    late GameController gameController;

    setUp(() {
      TestHelper.setupGetX();
      gameController = GameController();
      gameController.onInit();
    });

    tearDown(() {
      TestHelper.cleanupGetX();
    });

    group('Initialization', () {
      test('should initialize with valid game state', () {
        expect(gameController.secretWord.length, equals(4));
        expect(gameController.secretWord, matches(RegExp(r'^[A-Z]{4}$')));
        expect(gameController.guesses, isEmpty);
        expect(gameController.score, equals(0));
        expect(gameController.isGameActive, isTrue);
      });

      test('should have empty text controller initially', () {
        expect(gameController.textController.text, isEmpty);
      });
    });

    group('New Game', () {
      test('should start new game and reset state', () {
        gameController.textController.text = 'TEST';

        gameController.startNewGame();

        expect(gameController.secretWord.length, equals(4));
        expect(gameController.guesses, isEmpty);
        expect(gameController.score, equals(0));
        expect(gameController.textController.text, isEmpty);
      });
    });

    group('Guess Submission', () {
      test('should submit valid guess and update state', () {
        final originalSecretWord = gameController.secretWord;
        gameController.textController.text = originalSecretWord;

        gameController.submitGuess();

        expect(gameController.guesses.length, equals(1));
        expect(gameController.guesses.first.word, equals(originalSecretWord));
        expect(gameController.guesses.first.isCorrect, isTrue);
        expect(gameController.score, equals(10));
        expect(gameController.textController.text, isEmpty);
      });

      test('should handle incorrect guess', () {
        final originalSecretWord = gameController.secretWord;
        final wrongGuess = originalSecretWord == 'CATS' ? 'DOGS' : 'CATS';
        gameController.textController.text = wrongGuess;

        gameController.submitGuess();

        expect(gameController.guesses.length, equals(1));
        expect(gameController.guesses.first.word, equals(wrongGuess));
        expect(gameController.guesses.first.isCorrect, isFalse);
        expect(gameController.score, equals(0));
        expect(gameController.textController.text, isEmpty);
      });

      test('should reject empty guess', () {
        gameController.textController.text = '';

        gameController.submitGuess();

        expect(gameController.guesses, isEmpty);
        expect(gameController.score, equals(0));
      });

      test('should reject guess with wrong length', () {
        gameController.textController.text = 'CAT';

        gameController.submitGuess();

        expect(gameController.guesses, isEmpty);
        expect(gameController.score, equals(0));
      });

      test('should handle multiple guesses correctly', () {
        final originalSecretWord = gameController.secretWord;
        final wrongGuess = originalSecretWord == 'CATS' ? 'DOGS' : 'CATS';

        gameController.textController.text = wrongGuess;
        gameController.submitGuess();

        gameController.textController.text = originalSecretWord;
        gameController.submitGuess();

        expect(gameController.guesses.length, equals(2));
        expect(gameController.guesses[0].word, equals(wrongGuess));
        expect(gameController.guesses[0].isCorrect, isFalse);
        expect(gameController.guesses[1].word, equals(originalSecretWord));
        expect(gameController.guesses[1].isCorrect, isTrue);
        expect(gameController.score, equals(10));
      });
    });

    group('Scoring System', () {
      test('should award 10 points for correct guess', () {
        final originalSecretWord = gameController.secretWord;
        gameController.textController.text = originalSecretWord;

        gameController.submitGuess();

        expect(gameController.score, equals(10));
      });

      test('should not award points for incorrect guess', () {
        final originalSecretWord = gameController.secretWord;
        final wrongGuess = originalSecretWord == 'CATS' ? 'DOGS' : 'CATS';
        gameController.textController.text = wrongGuess;

        gameController.submitGuess();

        expect(gameController.score, equals(0));
      });

      test('should accumulate points for multiple correct guesses', () {
        final originalSecretWord = gameController.secretWord;

        gameController.textController.text = originalSecretWord;
        gameController.submitGuess();
        gameController.textController.text = originalSecretWord;
        gameController.submitGuess();
        gameController.textController.text = originalSecretWord;
        gameController.submitGuess();

        expect(gameController.score, equals(30));
      });
    });

    group('Guess History', () {
      test('should maintain chronological order of guesses', () {
        final originalSecretWord = gameController.secretWord;
        final wrongGuess = originalSecretWord == 'CATS' ? 'DOGS' : 'CATS';

        gameController.textController.text = wrongGuess;
        gameController.submitGuess();

        gameController.textController.text = originalSecretWord;
        gameController.submitGuess();

        expect(gameController.guesses.length, equals(2));
        expect(gameController.guesses[0].word, equals(wrongGuess));
        expect(gameController.guesses[1].word, equals(originalSecretWord));
      });

      test('should record timestamps for each guess', () {
        final originalSecretWord = gameController.secretWord;
        final beforeGuess = DateTime.now();

        gameController.textController.text = originalSecretWord;
        gameController.submitGuess();

        final afterGuess = DateTime.now();

        expect(gameController.guesses.length, equals(1));
        expect(
          gameController.guesses.first.timestamp.isAfter(
            beforeGuess.subtract(Duration(seconds: 1)),
          ),
          isTrue,
        );
        expect(
          gameController.guesses.first.timestamp.isBefore(
            afterGuess.add(Duration(seconds: 1)),
          ),
          isTrue,
        );
      });

      test('should preserve all guess history', () {
        final originalSecretWord = gameController.secretWord;
        final guessWords = ['DOGS', 'BIRD', 'FISH', originalSecretWord];

        for (final word in guessWords) {
          gameController.textController.text = word;
          gameController.submitGuess();
        }

        expect(gameController.guesses.length, equals(4));
        for (int i = 0; i < guessWords.length; i++) {
          expect(gameController.guesses[i].word, equals(guessWords[i]));
          expect(
            gameController.guesses[i].isCorrect,
            equals(guessWords[i] == originalSecretWord),
          );
        }
      });
    });
  });
}
