
import 'package:flutter_course/controllers/game_controller.dart';
import 'package:get/get.dart';

class GameBinding extends Bindings{
  @override
  void dependencies() {
    injectGameController();
  }
  
  void injectGameController(){
    Get.lazyPut(() => GameController());
  }
}