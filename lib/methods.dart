import 'dart:math';

int getRandomIndex(List list) {
  final random = Random();
  return 1 + random.nextInt(list.length - 1); // index from 1 to list.length - 1
}
