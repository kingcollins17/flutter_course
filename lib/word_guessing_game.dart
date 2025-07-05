import 'package:flutter/material.dart';
import 'package:flutter_course/binding.dart';
import 'package:flutter_course/word_guessing_game_screen.dart';
import 'package:get/get.dart';
import 'dart:math';


class WordGuessingGame extends StatelessWidget {
  const WordGuessingGame({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GameBinding(),
      home: WordGuessingGameScreen()
    );
  }
}
