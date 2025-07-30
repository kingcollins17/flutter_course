import 'package:flutter_course/Random_Game/Controller/game_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  late GameController controller;

  setUp(() {
    Get.put(GameController());
    controller = Get.find<GameController>();
  });

  tearDown(() {
    Get.delete<GameController>();
  });

  group('Secret Word Selection', () {
    test('should select a valid random 4-letter word', () {
      expect(controller.secretWord.length, 4);
      expect(controller.words.contains(controller.secretWord), true);
    });
  });

  group('Guess Validation', () {
    test('should only accept 4-letter words', () {
      controller.setTextControllerText(0, 'a');
      controller.setTextControllerText(1, 'b');
      controller.setTextControllerText(2, 'c');
      controller.validateGuess();
      expect(controller.feedBack, 'Word must be 4 letters long.');
      controller.clearTextFields();
      controller.setTextControllerText(0, 'a');
      controller.setTextControllerText(1, 'b');
      controller.setTextControllerText(2, 'c');
      controller.setTextControllerText(3, 'd');
      controller.validateGuess();
      // expect the feedback to be something other than 'Word must be 4 letters long.'
      controller.clearTextFields();
      controller.setTextControllerText(0, 'a');
      controller.setTextControllerText(1, 'b');
      controller.setTextControllerText(2, 'c');
      controller.setTextControllerText(3, 'de');
      controller.validateGuess();
      expect(controller.feedBack, 'Word must be 4 letters long.');
    });

    test('should correctly tell if a guess is right or wrong', () {
      controller.guessSecretWords(controller.secretWord);
      expect(controller.isGuessedWordCorrect, true);
      expect(
        controller.feedBack,
        'Congratulations! You guessed the secret word!',
      );

      controller.guessSecretWords('dartz');
      expect(controller.isGuessedWordCorrect, false);
      expect(controller.feedBack, 'Word is not in the list. Please try again.');
    });
  });

  group('Scoring System', () {
    test('should add 10 points for each correct guess', () {
      controller.guessSecretWords(controller.secretWord);
      expect(controller.score, 10);
      controller.guessSecretWords(controller.secretWord);
      expect(controller.score, 20);
    });
  });

  group('Guess History', () {
    test('should save every guess along with the correct feedback', () {
      String secretWord = controller.secretWord;
      String wrongGuess = 'dart'; // choose a wrong guess
      if (wrongGuess == secretWord) {
        wrongGuess = 'code'; // ensure wrong guess is different from secret word
      }
      controller.guessSecretWords(wrongGuess);
      controller.guessSecretWords(secretWord);
      expect(controller.guessedWord.length, 2);
      expect(controller.guessedWord[0].guess, wrongGuess);
      if (controller.words.contains(wrongGuess)) {
        expect(
          controller.guessedWord[0].feedback,
          'The word is in the list but not the secret word. Please Try again!',
        );
      } else {
        expect(
          controller.guessedWord[0].feedback,
          'Word is not in the list. Please try again.',
        );
      }
      expect(controller.guessedWord[0].score, 0);
      expect(controller.guessedWord[0].isCorrect, false);
      expect(controller.guessedWord[1].guess, secretWord);
      expect(
        controller.guessedWord[1].feedback,
        'Congratulations! You guessed the secret word!',
      );
      expect(controller.guessedWord[1].score, 10);
      expect(controller.guessedWord[1].isCorrect, true);
      // for (var guess in controller.guessedWord) {
      //   print('Guess: ${guess.guess}, Feedback: ${guess.feedback}');
      // }
      expect(controller.guessedWord.length, 2);
    });
  });
}
