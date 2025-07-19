import 'package:test/test.dart';
import 'setup.dart';
import 'test_controller.dart';

void main() async {
  late TestGameController controller;

  setUpAll(() async {
    await setup();
  });

  setUp(() {
    controller = TestGameController();
    controller.loadGame();
  });

  test('Secret Word Selection test', () async {
    controller.getNewWord();
    expect(controller.secretWord, isNotNull);
  });

  group('Testing the Guess', () {
    test('Test Guess is right', () async {
      controller.assessGuess('love');
      expect(controller.isCorrect!, equals(true));
    });
    test('Test Guess is wrong', () async {
      controller.assessGuess('like');
      expect(controller.isCorrect!, equals(false));
    });
    test('Guess is only 4-letters', () async {
      controller.assessGuess('coosl');
      expect(controller.isCorrect, isNull);
    });
    test('Guess is not less or more than 4 letters ', () async {
      controller.assessGuess('cool');
      expect(controller.isCorrect, isNotNull);
    });
    test('Guess is only letters ', () async {
      controller.assessGuess('c(1l');
      expect(controller.isCorrect, isNull);
    });
  });

  group('Test Points Award', () {
    test('10 points added for each correct guess.', () async {
      final initialScore = controller.currentScore.value;
      controller.assessGuess('love');
      expect(controller.currentScore.value, equals(initialScore + 10));
    });
    test('10 points not added for each wrong guess.', () async {
      final initialScore = controller.currentScore.value;
      controller.assessGuess('dove');
      expect(controller.currentScore.value, equals(initialScore));
    });
  });

  test('Guess History test', () async {
    final initialHistoryLength = controller.previousGuess.length;
    controller.assessGuess('love');
    expect(controller.previousGuess.length, equals(initialHistoryLength + 1));
  });
}
