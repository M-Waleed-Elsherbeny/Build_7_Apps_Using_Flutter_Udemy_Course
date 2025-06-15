import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _circleSize = 100;
  final Tween<double> _tween = Tween<double>(begin: 0.0, end: 1.0);
  AnimationController? _starIconAnimationController;

  @override
  void initState() {
    _starIconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 4,
      ),
    );
    _starIconAnimationController!.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _mainBackGround(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buttonAnimated(),
              _starIconAnimation(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mainBackGround() {
    return TweenAnimationBuilder<double>(
      tween: _tween,
      curve: Curves.bounceInOut,
      duration: const Duration(seconds: 2),
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  Widget _buttonAnimated() {
    return GestureDetector(
      onTap: () {
        _circleSize += _circleSize == 200 ? -100 : 100;
        setState(() {});
      },
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.bounceInOut,
          height: _circleSize,
          width: _circleSize,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(_circleSize),
          ),
          child: Center(
            child: Text(
              'Click',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _starIconAnimation() {
    return AnimatedBuilder(
      animation: _starIconAnimationController!.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _starIconAnimationController!.value * 2 * pi,
          child: Icon(
            Icons.star,
            size: 100,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
