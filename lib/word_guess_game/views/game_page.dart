import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';

class GamePage extends StatelessWidget {
  final GameController controller = Get.put(GameController());

  final TextEditingController guessController = TextEditingController();

  GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Guess Game'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => Text(
              'Score: ${controller.score.value}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 20),

            TextField(
              controller: guessController,
              maxLength: 4,
              decoration: InputDecoration(
                labelText: 'Enter 4-letter word',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                final guess = guessController.text.trim().toLowerCase();
                controller.makeGuess(guess);
                guessController.clear();
              },
              child: const Text('Submit Guess'),
            ),

            const SizedBox(height: 20),
            const Text('Guess History:', style: TextStyle(fontWeight: FontWeight.bold)),

            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.guessHistory.length,
                itemBuilder: (context, index) {
                  final entry = controller.guessHistory[index];
                  return ListTile(
                    title: Text(entry["guess"]!),
                    trailing: Text(entry["feedback"]!),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
