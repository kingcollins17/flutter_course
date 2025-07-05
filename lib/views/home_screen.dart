import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController guessCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find<GameController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '4-Letter Word Guessing Game',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child:
                    controller.displayMainHint.value
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'I have guessed a 4-letter word.\n Try to guess the word. \nType your guess in the box below.\n\n Hint: ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '\'${controller.secretWord.wordhints[0]}\'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                        : historyDisplayWidget(controller),
              ),
              Obx(
                () =>
                    controller.newGuessMessage.value
                        ? NewGuessMessage(controller: controller)
                        : SizedBox(height: 50),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Attempts Left: ${controller.remainingTry}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Score: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: '${controller.currentScore}',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 30, 80, 31),
                            fontSize: 16,
                            //      fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              TextField(
                controller: guessCtrl,
                maxLength: 4,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[^\d]+')),
                ],
                decoration: InputDecoration(
                  enabled: controller.remainingTry.value != 0,
                  labelText: "Enter 4-letter word",
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade600,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed:
                    controller.remainingTry.value == 0
                        ? null
                        : () {
                          controller.displayMainHint.value = false;
                          controller.newGuessMessage.value = false;
                          controller.assessGuess(guessCtrl.text.toLowerCase());
                          guessCtrl.clear();
                        },
                child: Text("Guess"),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed: () {
            controller.newGuessMessage.value = true;
            controller.displayMainHint.value = false;
            guessCtrl.clear();
            controller.resetGame();
          },
          backgroundColor:
              controller.remainingTry.value == 0
                  ? Colors.red
                  : Colors.green.shade100,
          child: Icon(
            Icons.refresh,
            size: controller.remainingTry.value == 0 ? 40 : 20,
          ),
        ),
      ),
    );
  }

  SingleChildScrollView historyDisplayWidget(GameController controller) {
    return SingleChildScrollView(
      reverse: true,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.previousGuess.length,
        itemBuilder: (context, index) {
          final guess = controller.previousGuess[index];
          return ListTile(
            title: Text(
              guess.word.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: guess.hints == null ? Colors.green : Colors.red,
                fontSize: 18,
              ),
            ),
            subtitle:
                guess.hints == null
                    ? Text(guess.feedback)
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(guess.feedback),
                        Text('hints'),
                        ...guess.hints!.map(
                          (e) => Text(
                            " - $e",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
          );
        },
      ),
    );
  }
}

class NewGuessMessage extends StatelessWidget {
  const NewGuessMessage({super.key, required this.controller});

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        children: [
          Text(
            'I have guessed a new word.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Hint: '),
                TextSpan(
                  text: '\'${controller.secretWord.wordhints[0]}\'',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
