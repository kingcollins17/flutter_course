import 'package:flutter/material.dart';
import 'package:flutter_course/Random_Game/Controller/game_controller.dart';
import 'package:get/get.dart';

class History extends StatelessWidget {
   History({super.key});
    final controller = Get.find<GameController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
          children: [
            Text('Game History',
            style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 28, 18, 46)
            ),),
            Expanded(
              child: ListView.builder(
                itemCount: controller.guessedWord.length,
                itemBuilder: (context,index){
                  int reversedIndex = controller.guessedWord.length-1-index;
                  return Container(
                    width: double.infinity,
                    height: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Obx(()=>
                       ListTile(
                        title: Text(controller.guessedWord[reversedIndex].guess,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: controller.guessedWord[reversedIndex].isCorrect
                            ? Colors.green
                            : Colors.red,

                        ),),
                         subtitle: Text(controller.guessedWord[reversedIndex].feedback),
                         trailing: Text('Score: ${controller.guessedWord[reversedIndex].score}'),
                      
                      ),
                    ),
                  );
              }),
            )
          ],
        ),
    );
  }
}

class Guess {
  String guess;
  String feedback;
  int score;
  bool isCorrect;

  Guess({required this.guess, required this.feedback, required this.score,required this.isCorrect});
}
