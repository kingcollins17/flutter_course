import 'package:flutter/material.dart';
import 'package:flutter_course/Random_Game/Controller/game_controller.dart';
import 'package:flutter_course/Random_Game/game_screen.dart';
import 'package:flutter_course/Random_Game/history_screen.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.find<GameController>();
    List<Widget> pages = [
    GameScreen(),
    HistoryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(()=>
           pages[controller.selectedIndex.value]),
        bottomNavigationBar: Obx(()=>
          BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: const Color.fromARGB(255, 98, 9, 241),
            onTap: (index){
              controller.changePageIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,),
                label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'History'),
            ]),
        )
      ),
    );
  }
}