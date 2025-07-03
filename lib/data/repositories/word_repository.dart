import 'dart:math';

class WordRepository {
  final List<String> _words = [
    'CATS',
    'DOGS',
    'BIRD',
    'FISH',
    'TREE',
    'BOOK',
    'GAME',
    'CODE',
    'LOVE',
    'HOPE',
    'TIME',
    'LIFE',
    'BLUE',
    'MOON',
    'STAR',
    'GOLD',
    'FIRE',
    'WIND',
    'RAIN',
    'SNOW',
    'ROCK',
    'SAND',
    'WAVE',
    'CAKE',
    'ROSE',
    'BEAR',
    'LION',
    'DUCK',
    'FROG',
    'GIFT',
    'RING',
    'KEYS',
  ];

  String getRandomWord() {
    final random = Random();
    return _words[random.nextInt(_words.length)];
  }

  bool isValidWord(String word) {
    return word.length == 4 && word.isNotEmpty;
  }
}
