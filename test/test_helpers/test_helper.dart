import 'package:get/get.dart';

class TestHelper {
  static void setupGetX() {
    Get.testMode = true;
  }

  static void cleanupGetX() {
    Get.reset();
  }

  static List<String> getInvalidWords() {
    return [
      '',
      'A',
      'AB',
      'ABC',
      'ABCDE',
      'ABCDEF',
      '1234',
      'AB12',
      'ab cd',
      '    ',
      'CAT',
      'DOGS1',
      'BIRD123',
    ];
  }

  static List<String> getValidWords() {
    return [
      'CATS',
      'DOGS',
      'BIRD',
      'FISH',
      'TREE',
      'BOOK',
      'LOVE',
      'HOPE',
      'TIME',
      'LIFE',
      'STAR',
      'GOLD',
      'GAME',
      'CODE',
      'BLUE',
      'MOON',
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
  }
}
