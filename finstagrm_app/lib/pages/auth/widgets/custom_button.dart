import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.deviceWidth,
    this.deviceHeight,
    this.onPressed,
    this.buttonText,
  });
  final double? deviceWidth, deviceHeight;
  final VoidCallback? onPressed;
  final String? buttonText;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.redAccent,
      minWidth: deviceWidth,
      height: deviceHeight,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        buttonText ?? 'Add Button Text',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
