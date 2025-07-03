import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';

class GuessHistoryWidget extends StatelessWidget {
  const GuessHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find();

    return Obx(
      () => Container(
        child:
            controller.guesses.isEmpty
                ? Center(
                  child: Text(
                    'No guesses yet!\nStart guessing to see your history.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                )
                : ListView.builder(
                  itemCount: controller.guesses.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final guess = controller.guesses[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            guess.isCorrect
                                ? Colors.green.withAlpha(30)
                                : Colors.red.withAlpha(30),
                        border: Border.all(
                          color: guess.isCorrect ? Colors.green : Colors.red,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  guess.isCorrect ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              guess.word,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            guess.isCorrect ? Icons.check_circle : Icons.cancel,
                            color: guess.isCorrect ? Colors.green : Colors.red,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            guess.isCorrect ? 'Correct! +10 pts' : 'Try again',
                            style: TextStyle(
                              color:
                                  guess.isCorrect ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${guess.timestamp.hour.toString().padLeft(2, '0')}:${guess.timestamp.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
