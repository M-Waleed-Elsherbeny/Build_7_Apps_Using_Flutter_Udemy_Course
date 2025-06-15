import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  BuildContext context;
  List? questions;
  int currentQuestionIndex = 0, score = 0;
  final String questionsDifficulty;

  GamePageProvider({required this.questionsDifficulty, required this.context}) {
    log("GamePageProvider created");
    getQuestionsFromAPI();
  }

  Future<void> getQuestionsFromAPI() async {
    String baseUrl = "https://opentdb.com/api.php";
    var response = await _dio.get(
      baseUrl,
      queryParameters: {
        "amount": 10,
        "type": "boolean",
        "difficulty": questionsDifficulty,
      },
    );

    Map<String, dynamic> data = jsonDecode(response.toString());
    questions = data['results'];
    notifyListeners();
  }

  String getCurrentQuestion() {
    Pattern pattern = RegExp(r"&quot;|&amp;|&apos;|&gt;|&lt;|&#039;| &eacute;");
    return questions![currentQuestionIndex]['question']
        .toString()
        .replaceAllMapped(pattern, (match) {
          switch (match.group(0)) {
            case "&quot;":
              return '"';
            case "&amp;":
              return '&';
            case "&apos;":
              return "'";
            case "&gt;":
              return '>';
            case "&lt;":
              return '<';
            case "&#039;":
              return "'";
            case " &eacute;":
              return 'e';
            default:
              return match.group(0)!;
          }
        });
  }

  void checkAnswer({required String answer}) async {
    log("currentQuestionIndex: ${currentQuestionIndex.toString()}");
    bool correctAnswer =
        questions![currentQuestionIndex]['correct_answer'] == answer;
    currentQuestionIndex++;
    score += correctAnswer ? 1 : 0;
    log("score: ${score.toString()}");
    log(correctAnswer ? "Correct Answer" : "Wrong Answer");
    showDialog(
      barrierColor:
          correctAnswer
              ? Colors.green.shade400.withAlpha(50)
              : Colors.red.shade400.withAlpha(50),
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          icon: Icon(
            correctAnswer ? Icons.check_circle : Icons.cancel,
            size: 150,
            color: correctAnswer ? Colors.green : Colors.red,
          ),
        );
      },
    );
    await Future.delayed(Duration(seconds: 1));
    if (!context.mounted) {
      return;
    }
      Navigator.pop(context);
    if (currentQuestionIndex == 10) {
      calculateScore();
    } else {
      notifyListeners();
    }
  }

  void reset() {
    currentQuestionIndex = 0;
    score = 0;
  }

  Future<void> calculateScore() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "All Questions : $currentQuestionIndex \n",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: "Correct Answer : $score \n",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: "Wrong Answer : ${currentQuestionIndex - score}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    await Future.delayed(Duration(seconds: 5));
    if (context.mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
    reset();
  }
}
