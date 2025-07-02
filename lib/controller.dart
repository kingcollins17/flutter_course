import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GameController extends GetxController{

  final List<String> wordList = ['grace', 'play', 'wish', 'draw', 'deer', 'fear',
    'join', 'idea', 'less', 'city', 'jump', 'high', 'form', 'earn', 'hope', 'line',
    'just', 'king', 'cake', 'cell', 'gift', 'fuel','door', 'heat', 'heal', 'lock'];

  late String secretWord;
  final RxInt score = 0.obs;
  final RxList<String> guessHistory = <String>[].obs;
  final TextEditingController guessController = TextEditingController();
  final RxBool gameOver = false.obs;
  int attempts = 0;
  int maxAttempts = 6;

  @override void onInit() {
    super.onInit();
    generateSecretWord();
  }

  void generateSecretWord(){
    secretWord = wordList[Random().nextInt(wordList.length)];
    guessHistory.clear();
    score.value = 0;
    attempts = 0;
    gameOver.value = false;
  }

  void resetGame(){
    generateSecretWord();
    guessController.clear();
  }

  int countMatchingLetters(String guess){
    int match = 0;
    for(int i = 0; i < 4; i++){
      if(secretWord.contains(guess[i])){
        match++;
      }
    }
    return match;
  }

  String generateHint(String guess){
    StringBuffer hint = StringBuffer();
    for(int i =0; i<4; i++){
      if(guess[i] == secretWord[i]){
        hint.write(guess[i]);
      }else{
        hint.write('_');
      }
    }
    return hint.toString();
  }

  void checkGuess(String guess){
    if(gameOver.value) return;

    if(guess.length !=4){
      Get.snackbar('Invalid Guess', 'Please enter a 4-letter word');
      return;
    }

    attempts++;

    if(guess.toLowerCase() == secretWord){
      guessHistory.add('$guess - Correct! The secret word was $secretWord');
      generateSecretWord();
    }else{
      int matches = countMatchingLetters(guess.toLowerCase());
      String hint = generateHint(guess.toLowerCase());
      guessHistory.add('$guess - $matches matched | Hint: $hint');
    }

    if(attempts>= maxAttempts){
      gameOver.value = true;
      guessHistory.add('Game over! The word was $secretWord');
    }
    guessController.clear();
  }


}