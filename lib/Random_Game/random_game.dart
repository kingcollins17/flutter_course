import 'package:flutter/material.dart';
import 'package:flutter_course/Random_Game/Controller/game_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class RandomGame extends StatefulWidget {
  const RandomGame({super.key});

  @override
  State<RandomGame> createState() => _RandomGameState();
}

class _RandomGameState extends State<RandomGame> {
  final formKey = GlobalKey<FormState>();
  final controller = Get.find<GameController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'WELCOME TO RANDOMIZE',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 98, 9, 241),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'This is a game where you can guess a secret word! and earn points.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'You will be given a hint and you have to guess the word.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Can you guess the secret word?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter the Word below to guess the secret word:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => _buildRandonBoxUi(context, index),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // controller.guessSecretWords( controller.textControllers.map((e) => e.text).join());
                      controller.validateGuess();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 98, 9, 241),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Check Guess',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRandonBoxUi(BuildContext context, int index) {
    return Column(
      children: [
        SizedBox(
          height: 68.0,
          width: 64.0,
          child: TextFormField(
            controller: controller.textControllers[index],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            },
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
            ],
            decoration: boxDecoration(),
          ),
        ),
      ],
    );
  }

  InputDecoration boxDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1),
      ),
    );
  }
}
