import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_course/data/repositories/word_repository.dart';
import '../../test_helpers/test_helper.dart';

void main() {
  group('WordRepository Tests', () {
    late WordRepository wordRepository;

    setUp(() {
      wordRepository = WordRepository();
    });

    group('Secret Word Selection', () {
      test('should return a valid 4-letter word', () {
        final word = wordRepository.getRandomWord();

        expect(word.length, equals(4));
        expect(word, isNotEmpty);
        expect(word, matches(RegExp(r'^[A-Z]{4}$')));
      });

      test('should return different words on multiple calls', () {
        // Act
        final words = <String>{};
        for (int i = 0; i < 50; i++) {
          words.add(wordRepository.getRandomWord());
        }

        expect(words.length, greaterThan(1));
      });

      test('should only return words from predefined list', () {
        final validWords = TestHelper.getValidWords();

        final words = <String>{};
        for (int i = 0; i < 100; i++) {
          words.add(wordRepository.getRandomWord());
        }

        for (final word in words) {
          expect(
            validWords.contains(word),
            isTrue,
            reason: 'Word "$word" not in predefined list',
          );
        }
      });
    });

    group('Guess Validation', () {
      test('should validate 4-letter words as valid', () {
        final validWords = TestHelper.getValidWords();

        for (final word in validWords) {
          expect(
            wordRepository.isValidWord(word),
            isTrue,
            reason: 'Word "$word" should be valid',
          );
        }
      });

      test('should reject words with incorrect length', () {
        final invalidWords = TestHelper.getInvalidWords();

        for (final word in invalidWords) {
          expect(
            wordRepository.isValidWord(word),
            isFalse,
            reason: 'Word "$word" should be invalid',
          );
        }
      });

      test('should reject empty strings', () {
        expect(wordRepository.isValidWord(''), isFalse);
        expect(wordRepository.isValidWord('   '), isFalse);
      });
    });
  });
}
