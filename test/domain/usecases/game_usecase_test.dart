import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_course/domain/usecases/game_usecase.dart';
import 'package:flutter_course/domain/entities/game_state.dart';

void main() {
  group('GameUsecase Tests', () {
    late GameUsecase gameUsecase;

    setUp(() {
      gameUsecase = GameUsecase();
    });

    group('Game Initialization', () {
      test('should initialize game with valid state', () {
        final gameState = gameUsecase.initializeGame();

        expect(gameState.secretWord.length, equals(4));
        expect(gameState.secretWord, matches(RegExp(r'^[A-Z]{4}$')));
        expect(gameState.guesses, isEmpty);
        expect(gameState.score, equals(0));
        expect(gameState.isGameActive, isTrue);
      });

      test(
        'should initialize different games with potentially different secret words',
        () {
          final gameStates = <String>{};
          for (int i = 0; i < 20; i++) {
            gameStates.add(gameUsecase.initializeGame().secretWord);
          }

          expect(gameStates.length, greaterThan(1));
        },
      );
    });

    group('Guess Processing', () {
      late GameState initialGameState;

      setUp(() {
        initialGameState = GameState(
          secretWord: 'CATS',
          guesses: [],
          score: 0,
          isGameActive: true,
        );
      });

      test('should process correct guess and update score', () {
        final newGameState = gameUsecase.processGuess(initialGameState, 'CATS');

        expect(newGameState.secretWord, equals('CATS'));
        expect(newGameState.guesses.length, equals(1));
        expect(newGameState.guesses.first.word, equals('CATS'));
        expect(newGameState.guesses.first.isCorrect, isTrue);
        expect(newGameState.score, equals(10));
        expect(newGameState.isGameActive, isTrue);
      });

      test('should process incorrect guess without updating score', () {
        final newGameState = gameUsecase.processGuess(initialGameState, 'DOGS');

        expect(newGameState.secretWord, equals('CATS'));
        expect(newGameState.guesses.length, equals(1));
        expect(newGameState.guesses.first.word, equals('DOGS'));
        expect(newGameState.guesses.first.isCorrect, isFalse);
        expect(newGameState.score, equals(0));
        expect(newGameState.isGameActive, isTrue);
      });

      test('should convert lowercase guess to uppercase', () {
        final newGameState = gameUsecase.processGuess(initialGameState, 'cats');

        expect(newGameState.guesses.first.word, equals('CATS'));
        expect(newGameState.guesses.first.isCorrect, isTrue);
        expect(newGameState.score, equals(10));
      });

      test('should handle mixed case guess', () {
        final newGameState = gameUsecase.processGuess(initialGameState, 'CaTs');

        expect(newGameState.guesses.first.word, equals('CATS'));
        expect(newGameState.guesses.first.isCorrect, isTrue);
        expect(newGameState.score, equals(10));
      });

      test('should reject invalid length words', () {
        final newGameState1 = gameUsecase.processGuess(initialGameState, 'CAT');
        final newGameState2 = gameUsecase.processGuess(
          initialGameState,
          'CATSS',
        );
        final newGameState3 = gameUsecase.processGuess(initialGameState, '');

        expect(newGameState1.guesses, isEmpty);
        expect(newGameState1.score, equals(0));
        expect(newGameState2.guesses, isEmpty);
        expect(newGameState2.score, equals(0));
        expect(newGameState3.guesses, isEmpty);
        expect(newGameState3.score, equals(0));
      });

      test('should accumulate multiple guesses and score', () {
        GameState currentState = initialGameState;

        currentState = gameUsecase.processGuess(currentState, 'DOGS');

        currentState = gameUsecase.processGuess(currentState, 'BIRD');

        currentState = gameUsecase.processGuess(currentState, 'CATS');

        expect(currentState.guesses.length, equals(3));
        expect(currentState.guesses[0].word, equals('DOGS'));
        expect(currentState.guesses[0].isCorrect, isFalse);
        expect(currentState.guesses[1].word, equals('BIRD'));
        expect(currentState.guesses[1].isCorrect, isFalse);
        expect(currentState.guesses[2].word, equals('CATS'));
        expect(currentState.guesses[2].isCorrect, isTrue);
        expect(currentState.score, equals(10));
      });

      test('should handle multiple correct guesses', () {
        GameState currentState = GameState(
          secretWord: 'CATS',
          guesses: [],
          score: 0,
          isGameActive: true,
        );

        currentState = gameUsecase.processGuess(currentState, 'CATS');

        currentState = gameUsecase.processGuess(currentState, 'CATS');

        expect(currentState.guesses.length, equals(2));
        expect(currentState.guesses[0].isCorrect, isTrue);
        expect(currentState.guesses[1].isCorrect, isTrue);
        expect(currentState.score, equals(20));
      });
    });

    group('Game Reset', () {
      test('should reset game to initial state', () {
        final gameState = gameUsecase.resetGame();

        expect(gameState.secretWord.length, equals(4));
        expect(gameState.secretWord, matches(RegExp(r'^[A-Z]{4}$')));
        expect(gameState.guesses, isEmpty);
        expect(gameState.score, equals(0));
        expect(gameState.isGameActive, isTrue);
      });

      test('should generate new secret word on reset', () {
        final words = <String>{};
        for (int i = 0; i < 20; i++) {
          words.add(gameUsecase.resetGame().secretWord);
        }

        expect(words.length, greaterThan(1));
      });
    });
  });
}
