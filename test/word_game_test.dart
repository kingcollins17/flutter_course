import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_course/word_guess_game/controllers/game_controller.dart';

void main() {
  group('Secret Word Selection', () {
    test('should select a 4-letter word', () {
      final gameController = GameController();
      gameController.onInit();

      final secretWord = gameController.secretWord;
      print('Secret word: $secretWord');

      expect(secretWord.length, 4);
    });
  });

  group('Guess Validation', () {
    test('should correctly validate a correct guess', () {
      final gameController = GameController();
      gameController.onInit();

      gameController.secretWord = 'tree';
      gameController.validateGuess('tree');

      expect(gameController.isCorrectGuess, true);
    });

    test('should correctly validate an incorrect guess', () {
      final gameController = GameController();
      gameController.onInit();

      gameController.secretWord = 'tree';
      gameController.validateGuess('wood');

      expect(gameController.isCorrectGuess, false);
    });

    test('Input Length Validation - should reject guesses that are not 4 letters', () {
      final controller = GameController();
      controller.secretWord = 'tree';

      expect(() => controller.validateGuess('tr'), throwsArgumentError);
      expect(() => controller.validateGuess('trees'), throwsArgumentError);
    });
  });

  group('Scoring System', () {
    test('should add 10 points for each correct guess', () {
      final controller = GameController(words: ['game']);
      controller.secretWord = 'game';

      expect(controller.score.value, equals(0));

      final result1 = controller.makeGuess('game');
      expect(result1, isTrue);
      expect(controller.score.value, equals(10));

      final result2 = controller.makeGuess('game');
      expect(result2, isTrue);
      expect(controller.score.value, equals(20));
    });
  });

  //good

group('Guess History', () {
  test(
    'should store guess and feedback correctly',
    () {
      final controller = GameController(words: ['game']);
      controller.secretWord = 'game';

      controller.makeGuess('game');
      controller.makeGuess('fail');

      expect(controller.guessHistory.length, equals(2));

      expect(controller.guessHistory[0]['guess'], equals('game'));
      expect(controller.guessHistory[0]['isCorrect'], isTrue);

      expect(controller.guessHistory[1]['guess'], equals('fail'));
      expect(controller.guessHistory[1]['isCorrect'], isFalse);
    },
    skip: true,
  );
});
}