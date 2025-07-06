import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/game_page.dart';

void main() {
  runApp(const WordGuessApp());
}

class WordGuessApp extends StatelessWidget {
  const WordGuessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Word Guess Game',
      home: GamePage(),
    );
  }
}
