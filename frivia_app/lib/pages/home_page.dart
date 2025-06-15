import 'package:flutter/material.dart';
import 'game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _sliderValue = 0;
  List<String> questionsDifficulty = ["Easy", "Medium", "Hard"];
  double? _deviceWidth, _deviceHeight;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Frivia Questions".toUpperCase(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              questionsDifficulty[_sliderValue.toInt()].toUpperCase(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Slider(
              value: _sliderValue,
              onChanged: (index) {
                _sliderValue = index;
                setState(() {});
              },
              min: 0,
              max: 2,
              divisions: 2,
              thumbColor: Colors.blueAccent,
              activeColor: Colors.blueAccent,

              label: questionsDifficulty[_sliderValue.toInt()].toUpperCase(),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => GamePage(
                          questionsDifficulty:
                              questionsDifficulty[_sliderValue.toInt()]
                                  .toLowerCase(),
                        ),
                  ),
                );
              },
              minWidth: _deviceWidth! * 0.80,
              height: _deviceHeight! * 0.08,
              color: Colors.blueAccent,
              child: Text(
                "Start".toUpperCase(),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
