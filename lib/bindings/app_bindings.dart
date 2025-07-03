
import 'package:flutter_course/Random_Game/Controller/game_controller.dart';
import 'package:get/get.dart';



class MyBindings implements Bindings{
  @override
  void dependencies() {
   Get.put(GameController(),permanent: true);
  //  Get.put(CommunityController());

  }
  
}