import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_course/domain/entities/game_state.dart';
import 'package:flutter_course/data/models/guess_model.dart';

void main() {
  group('GameState Tests', () {
    test('should create GameState with initial values', () {
      final gameState = GameState(
        secretWord: 'CATS',
        guesses: [],
        score: 0,
        isGameActive: true,
      );

      expect(gameState.secretWord, equals('CATS'));
      expect(gameState.guesses, isEmpty);
      expect(gameState.score, equals(0));
      expect(gameState.isGameActive, isTrue);
    });

    test('should create GameState with guesses and score', () {
      final guess = GuessModel(
        word: 'DOGS',
        isCorrect: true,
        timestamp: DateTime.now(),
      );

      final gameState = GameState(
        secretWord: 'CATS',
        guesses: [guess],
        score: 10,
        isGameActive: true,
      );

      expect(gameState.secretWord, equals('CATS'));
      expect(gameState.guesses.length, equals(1));
      expect(gameState.guesses.first, equals(guess));
      expect(gameState.score, equals(10));
      expect(gameState.isGameActive, isTrue);
    });
  });
}
