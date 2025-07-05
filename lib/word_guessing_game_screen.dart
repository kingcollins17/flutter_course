import 'package:flutter/material.dart';
import 'package:flutter_course/controller.dart';
import 'package:get/get.dart';

class WordGuessingGameScreen extends StatelessWidget {
  const WordGuessingGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GameController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Word Guessing Game',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.brown,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                        () => Text(
                      'Score: ${controller.score.value}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => controller.score.value =0,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text('Reset Score', style: TextStyle(color: Colors.white))
                  )
                ],
              ),
              Obx(
                () => Text(
                  'Attempts: ${controller.attempts.value}/${controller.maxAttempts}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 30),
              Obx(
                () =>
                    controller.gameOver.value
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Game Over! Press Reset to play again',
                              style: TextStyle(color: Colors.red, fontSize: 22),
                            ),
                            ElevatedButton(
                              onPressed: controller.resetGame,
                              child: const Text('Reset'),
                            ),
                          ],
                        )
                        : Column(
                          children: [
                            TextField(
                              controller: controller.guessController,
                              decoration: const InputDecoration(
                                labelText: 'Enter your guess',
                                border: OutlineInputBorder(),
                              ),
                              onSubmitted: controller.checkGuess,
                            ),

                            const SizedBox(height: 20),
                            Center(
                              child:
                                  controller.isCorrectGuess.value
                                      ? ElevatedButton(
                                        onPressed: controller.resetGame,
                                        child: const Text(
                                          'Play Again',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                      : ElevatedButton(
                                        onPressed:
                                            () => controller.checkGuess(
                                              controller.guessController.text,
                                            ),
                                        child: const Text(
                                          'Guess',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                            ),
                          ],
                        ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Guess History',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.guessHistory.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.guessHistory[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
