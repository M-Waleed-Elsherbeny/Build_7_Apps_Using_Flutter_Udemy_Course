import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final double deviceWidth, deviceHeight;
  final Widget? child;
  const InfoCard({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth,
      height: deviceHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
