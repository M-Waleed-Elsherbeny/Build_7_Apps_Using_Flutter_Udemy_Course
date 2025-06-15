// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:frivia_app/providers/game_page_provider.dart';
import 'package:provider/provider.dart';


class GamePage extends StatelessWidget {
  GamePage({
    super.key,
    required this.questionsDifficulty,
  });
  double? _deviceWidth, _deviceHeight;
  late GamePageProvider _gamePageProvider;
  final String questionsDifficulty;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(context: context, questionsDifficulty: questionsDifficulty),
      builder: (context, child) {
        _gamePageProvider = context.watch<GamePageProvider>();
        if (_gamePageProvider.questions != null) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "${_gamePageProvider.currentQuestionIndex + 1} / 10",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  questionCard(),
                  SizedBox(height: _deviceHeight! * 0.05),
                  Column(
                    children: [
                      buttonCard(
                        buttonText: "True",
                        onPressed: () {
                          _gamePageProvider.checkAnswer(answer: "True");
                        },
                        buttonColor: Colors.green,
                      ),
                      SizedBox(height: _deviceHeight! * 0.03),
                      buttonCard(
                        buttonText: "False",
                        onPressed: () {
                          _gamePageProvider.checkAnswer(answer: "False");
                        },
                        buttonColor: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }
      },
    );
  }

  Widget questionCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      child: Text(
        _gamePageProvider.getCurrentQuestion(),
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buttonCard({
    required String buttonText,
    required Function() onPressed,
    required Color? buttonColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: _deviceWidth! * 0.80,
        height: _deviceHeight! * 0.08,
        color: buttonColor,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
