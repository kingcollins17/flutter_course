class GuessModel {
  final String word;
  final bool isCorrect;
  final DateTime timestamp;

  GuessModel({
    required this.word,
    required this.isCorrect,
    required this.timestamp,
  });
}
