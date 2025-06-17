import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IbmiScreen extends StatefulWidget {
  const IbmiScreen({super.key});

  @override
  State<IbmiScreen> createState() => _IbmiScreenState();
}

class _IbmiScreenState extends State<IbmiScreen> {
  double? deviceWidth, deviceHeight;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: deviceWidth! * 0.45,
                  height: deviceHeight! * 0.20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                ),
                Container(
                  width: deviceWidth! * 0.45,
                  height: deviceHeight! * 0.20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: deviceHeight! * 0.05),
            Container(
              width: deviceWidth! * 0.85,
              height: deviceHeight! * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
            ),
            SizedBox(height: deviceHeight! * 0.05),
            Container(
              width: deviceWidth! * 0.85,
              height: deviceHeight! * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
            ),
            SizedBox(height: deviceHeight! * 0.05),
            CupertinoButton(
              color: Colors.blueAccent.shade200,
              child: const Text(
                "Calculate IBMI",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
