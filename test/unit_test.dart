import 'package:flutter_course/controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
//import 'package:test/test.dart';

void main () {

  late GameController gameController;

  setUp((){
    gameController = GameController();
    gameController.secretWord = 'play';
    Get.testMode = true;
  });

  group('GameController Class -', (){

    test('given generateSecretWord method when it is called, then a valid 4-letter '
        'word is chosen at the start of game',
            (){
                //assign - initialized already in my setUp function
                //act
                gameController.generateSecretWord();
                //assert
                expect(gameController.wordList.contains(gameController.secretWord), isTrue);
                expect(gameController.secretWord.length, equals(4));
        }
    );
    
    test('given checkGuess method when it is called, then guesses that are not '
        '4-letter words are rejected',
            (){
                //assign - initialized already in my setUp function
                //act
                gameController.checkGuess('cat');
                //assert
                expect(gameController.attempts.value, equals(0));
                expect(gameController.guessHistory, isEmpty);
            });

    test('given checkGuess method when it is called, then correct 4-letter guesses are '
        'accepted and recognized as correct, and 10 points added for each correct guess',
            (){
                //assign
                final initialScore = gameController.score.value;
                final numberOfAttempts = gameController.attempts.value;
                //act
                gameController.checkGuess('play');
                //assert
                expect(gameController.attempts.value, equals(numberOfAttempts + 1));
                expect(gameController.isCorrectGuess.value, isTrue);
                expect(gameController.score.value, equals(initialScore + 10));
                expect(gameController.guessHistory.isNotEmpty, isTrue);
                expect(gameController.guessHistory.last.contains('Correct!'), isTrue);
            });

    test('given checkGuess method when it is called, then wrong 4-letter guesses '
        'are accepted but recognized as wrong',
            (){
                //assign
                final initialScore = gameController.score.value;
                final numberOfAttempts = gameController.attempts.value;
                //act
                gameController.checkGuess('robe');
                //assert
                expect(gameController.attempts.value, equals(numberOfAttempts + 1));
                expect(gameController.isCorrectGuess.value, isFalse);
                expect(gameController.score.value, equals(initialScore));
                expect(gameController.guessHistory.isNotEmpty, isTrue);
                expect(gameController.guessHistory.last.contains('Hint:'), isTrue);
                expect(gameController.guessHistory.last.contains('matched'), isTrue);
            });

    test('given checkGuess method when it is called, then every 4-letter guess is saved'
        'along with the correct feedback',
            (){
                //assign
                //act
                gameController.checkGuess('robe');
                gameController.checkGuess('play');
                //assert - that guessHistory 2 two entries
                expect(gameController.guessHistory.length, equals(2));

                //assign - after guessHistory has been populated
                final firstEntry = gameController.guessHistory[0];
                final secondEntry = gameController.guessHistory[1];

                //assert
                expect(firstEntry.contains('robe'), isTrue);
                expect(firstEntry.contains('Hint:'), isTrue);
                expect(firstEntry.contains('matched'), isTrue);
                expect(secondEntry.contains('play'), isTrue);
                expect(secondEntry.contains('Correct!'), isTrue);
        });

  });
}