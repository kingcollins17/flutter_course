import 'package:flutter/material.dart';
import 'package:flutter_course/binding.dart';
import 'package:get/get.dart';


class WordGuessingGame extends StatelessWidget {
  const WordGuessingGame({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GameBinding(),
      home: WordGuessingGame()
    );
  }
}
