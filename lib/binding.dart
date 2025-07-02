import 'package:flutter_course/controller.dart';
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