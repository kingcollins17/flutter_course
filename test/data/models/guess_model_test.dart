import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_course/data/models/guess_model.dart';

void main() {
  group('GuessModel Tests', () {
    test('should create GuessModel with correct properties', () {
      final timestamp = DateTime.now();

      final guess = GuessModel(
        word: 'CATS',
        isCorrect: true,
        timestamp: timestamp,
      );

      expect(guess.word, equals('CATS'));
      expect(guess.isCorrect, isTrue);
      expect(guess.timestamp, equals(timestamp));
    });

    test('should create GuessModel for incorrect guess', () {
      final timestamp = DateTime.now();

      final guess = GuessModel(
        word: 'DOGS',
        isCorrect: false,
        timestamp: timestamp,
      );

      expect(guess.word, equals('DOGS'));
      expect(guess.isCorrect, isFalse);
      expect(guess.timestamp, equals(timestamp));
    });
  });
}
