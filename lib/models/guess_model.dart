import 'package:hive/hive.dart';

part 'guess_model.g.dart';

@HiveType(typeId: 0)
class GuessModel {
  @HiveField(0)
  final String word;

  @HiveField(1)
  final String feedback;

  @HiveField(2)
  final List<String>? hints;

  GuessModel({required this.word, required this.feedback,  this.hints});
}
